#!/bin/bash
set -x
sudo rm -fr /tmp/{data,logs}
mkdir -p /tmp/data/{hls,dash}
mkdir -p /tmp/logs/{vms,nginx}
cp ./nginx-vms/stats.xsl /tmp/data
cp ./test/test/cameras.txt /tmp/data/
sudo chown nobody /tmp/data/stats.xsl
docker-compose build
docker-compose up

