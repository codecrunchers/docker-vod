#!/bin/bash
#Cannot get this to write to volume
/bin/echo "{\"event\":\"hls_pub_start\",\"value\",\"$1\"}" >>/tmp/vms.log
echo "test" | tee --append /logs/vms/atest-start.log




