#!/bin/bash
#Grab a lock until we are done with file
#Read an entry from that file and remove the consumed entry.
#Connect to that stream after figuring out MAC / VENDOR login
#When we die - echo our original line back
set -e
set -x
mkdir -p /logs/vms
lock="/data/kvms.lock"
exec 200>$lock
flock -n 200 || exit 1
#if [ -s /data/cameras.txt ]; then #= If it's empty exit - cancel reststart - can lead to no workers depending on restart policy
#Find Stream info
IP=$(tail -n1  /data/cameras.txt | cut -d'!' -f1)
MAC_ID=$(tail -n1 /data/cameras.txt | cut -d'!' -f2  | sed 's/\:/_/g')
STREAM_URI=$(tail -n1 /data/cameras.txt | cut -d'!' -f3)
sed -i '$ d' /data/cameras.txt #Remove line we have consumed.  We have a lock
echo "{\"date\":\"$(date)\",\"service\":\"rtsp-client\",\"StreamName\":\"$MAC_ID\",\"src\":\"$IP\",\"action\":\"stream init\"}" \
    >> /logs/vms/rtsp-client.log
#Check Vendor
if [[ $MAC_ID =~ "00_02_D1" ]]; then #VIVOTEK
    URI="rtsp://USER:PASS$IP:554/live.sdp"
elif [[ $MAC_ID =~ "B8_27_EB" ]]; then #RASPBERRY PI
    URI="rtsp://$IP:8554/unicast"
elif [[ $MAC_ID =~ "AC_CC_8E" ]]; then #AXIS
    URI="rtsp://USER:PASS@$IP:554/axis-media/media.amp"
else
echo "{\"date"\:\"$(date)\","service\":\"rtsp-client\",\"StreamName\":\"$MAC_ID\",\"src\":\"$IP\",\"msg\":\"Unknow Vendor\"}" \
    >> /logs/vms/rtsp-client.log
    exit 2
fi
flock -u 200 #Release lock, we're done
#Stream
ffmpeg -i "$URI" -an -vcodec copy -f flv -s 1024x768 -rtmp_live recorded "rtmp://media-server/hlspub/$MAC_ID"
#We're done - reflect that in logs & entry file for now
echo "{\"date"\:\"$(date)\","service\":\"rtsp-client\",\"StreamName\":\"$MAC_ID\",\"src\":\"$IP\",\"action\":\"stream comsume end\"}" \
    >> /logs/vms/rtsp-client.log


#Push Feed back to db for next client to consume - tmp workaround
( 
  flock -x -w 1 200
  echo "In critical section"
  echo "$IP!$MAC_ID" >> /data/cameras.txt
  sleep 5 
) 200>/data/cameras.txt


