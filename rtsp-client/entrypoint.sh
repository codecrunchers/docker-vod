#!/bin/bash
#Grab a lock until we are done with file
set -e
set -x
mkdir -p /logs/vms
lock="/data/kvms.lock"
exec 200>$lock
flock -n 200 || exit 1
#if [ -s /data/cameras.txt ]; then #= If it's empty exit - cancel reststart - can lead to no workers
IP=$(tail -n1  /data/cameras.txt | cut -d'!' -f1)
MAC_ID=$(tail -n1 /data/cameras.txt | cut -d'!' -f2  | sed 's/\:/_/g')
export IP MAC_ID
sed -i '$ d' /data/cameras.txt #Remove line we have consumed.  We have a lock

echo "{\"date\":\"$(date)\",\"service\":\"rtsp-client\",\"StreamName\":\"$MAC_ID\",\"src\":\"$IP\",\"action\":\"stream init\"}" \
    >> /logs/vms/rtsp-client.log


if [[ $MAC_ID =~ "00_02_D1" ]]; then #VIVOTEK
    URI="rtsp://root:kepler123@$IP:554/live.sdp"
elif [[ $MAC_ID =~ "B8_27_EB" ]]; then #RASPBERRY PI
    URI="rtsp://$IP:8554/unicast"
elif [[ $MAC_ID =~ "AC_CC_8E" ]]; then #AXIS
    URI="rtsp://root:kepler123@$IP:554/axis-media/media.amp"
else
echo "{\"date"\:\"$(date)\","service\":\"rtsp-client\",\"StreamName\":\"$MAC_ID\",\"src\":\"$IP\",\"msg\":\"Unknow Vendor\"}" \
    >> /logs/vms/rtsp-client.log

    exit 2
fi
flock -u 200 #Release lock, we're done
ffmpeg -i "$URI" -stats -an -vcodec copy -f flv -s 32x32 -rtmp_live recorded "rtmp://media-server/hlspub/$MAC_ID"

echo "{\"date"\:\"$(date)\","service\":\"rtsp-client\",\"StreamName\":\"$MAC_ID\",\"src\":\"$IP\",\"action\":\"stream comsume end\"}" \
    >> /logs/vms/rtsp-client.log

#Push Feed back to db for next client to consume - tmp workaround
echo "$IP $MAC_ID" >> /data/cameras.txt

