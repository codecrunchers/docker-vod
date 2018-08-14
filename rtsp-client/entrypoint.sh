#!/bin/bash
set -e
set -x
lock="/var/run/kvms"
exec 200>$lock
flock -n 200 || exit 1
IP=$(tail  /data/cameras.txt | cut -d' ' -f 1) \
MAC_ID=$(tail  /data/cameras.txt | cut -d' ' -f 2) \
MAC_ID=$(echo "$MAC_ID" | sed 's/\:/_/g')
export IP MAC_ID
echo "Connecting to $IP/$MAC_ID"
ffmpeg -i "rtsp://$IP:8554/unicast" -stats -an -vcodec copy -f flv -s 32x32 -rtmp_live recorded "rtmp://media-server/hlspub/$MAC_ID"


