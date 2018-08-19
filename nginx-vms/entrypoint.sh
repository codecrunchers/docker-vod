#!/bin/bash
set -e
set -x
mkdir -p  -m 755 /home/nginx/logs/nginx/
mkdir -p -m 755 /home/nginx/logs/vms/
mkdir -p -m 755 /home/nginx/data/hls/
mkdir -p -m 755 /home/nginx/data/dash/
mkdir -p -m 755 /home/nginx/data/vod/
chown nginx:nginx /home/nginx/* -R
echo "{\"service\":\"nginx\",\"timestamp\":\"$date\",\"action\":\"scan init\"}" >> /home/nginx/logs/vms/discovery.log
exec "$@" #Run CMD + your parameters

