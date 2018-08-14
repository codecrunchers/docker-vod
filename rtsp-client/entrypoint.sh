#!/bin/bash
#Grab a lock until script has ended
set -e
lock="/var/run/kvms"
exec 200>$lock
flock -n 200 || exit 1
#if [ -s /data/cameras.txt ]; then #= If it's empty exit - cancel reststart - can lead to no workers
IP=$(tail  /data/cameras.txt | cut -d' ' -f 1)
MAC_ID=$(tail  /data/cameras.txt | cut -d' ' -f 2)
MAC_ID=$(echo "$MAC_ID" | sed 's/\:/_/g')
sed -i '$ d' /data/cameras.txt #Remove line we have consumed, we have a lock
export IP MAC_ID

echo "{\"date\":\"$(date)\",\"service\":\"rtsp-client\",\"StreamName\":\"$MAC_ID\",\"src\":\"$IP\",\"action\":\"stream init\"}" \
  >> /logs/vms/rtsp-client.log

#Convert to RTMP and Stream to Media Server
ffmpeg -i "rtsp://$IP:8554/unicast" -stats -an -vcodec copy -f flv -s 32x32 -rtmp_live recorded "rtmp://media-server/hlspub/$MAC_ID"

echo "{\"date"\:\"$(date)\","service\":\"rtsp-client\",\"StreamName\":\"$MAC_ID\",\"src\":\"$IP\",\"action\":\"stream comsume end\"}" \
    >> /logs/vms/rtsp-client.log

#Push Feed back to db for next client to consume - tmp workaround
echo "$IP $MAC_ID" >> /data/cameras.txt

