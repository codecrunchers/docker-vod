#!/bin/bash
#Cannot get this to write to volume
/bin/echo "{\"event\":\"hls_pub_end\",\"value\":\"$1\"}" >>  /home/nginx/logs/vms.log
echo "test" | tee --append  /home/nginx/logs/vms/atest-end.log





