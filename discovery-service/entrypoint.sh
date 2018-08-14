#!/bin/bash
/usr/bin/nmap -sP $CIDR | awk -v mac="$MAC_ID" '/report for/{r=$5}/MAC Address/{p=$3}$0~mac{print r,p}' > "/data/cameras.txt"

