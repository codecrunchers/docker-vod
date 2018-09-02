#!/bin/bash
#Cannot get this to write to volume
/bin/echo "{\"event\":\"hls_pub_start\",\"value\",\"$1\"}" >>  /home/nginx/logs/vms.log
echo "test" | tee --append /home/nginx/logs/vms/atest-start.log




