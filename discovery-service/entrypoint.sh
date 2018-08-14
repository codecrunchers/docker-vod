#!/bin/bash
set -e
lock="/var/run/kvms"
exec 200>$lock
flock -n 200 || exit 1
echo "{\"service\":\"discovery\",\"MAC\":\"$MAC_ID\",\"HOST\":\"$CIDR\",\"action\":\"scan init\"}" >> /logs/vms/discovery.log
/usr/bin/nmap -sP $CIDR | awk -v mac="$MAC_ID" '/report for/{r=$5}/MAC Address/{p=$3}$0~mac{print r,p}' >> /data/cameras.txt
echo "{\"service\":\"discovery\",\"MAC\":\"$MAC_ID\",\"HOST\":\"$CIDR\",\"action\":\"scan end\"}" >> /logs/vms/discovery.log


