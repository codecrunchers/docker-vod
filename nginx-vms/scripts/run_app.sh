#!/bin/bash
/bin/echo \"{\"event\":\"mp4_create\",\"value\":\"$1\"}\" >> /home/nginx/logs/vms.log
exec "$1" &



