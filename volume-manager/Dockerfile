FROM busybox

ENV STAGE test

RUN mkdir -p /data/hls && \
    mkdir /data/dash && \
    mkdir -p /logs/vms && \
    mkdir /logs/nginx && \
    touch /data/stats.xsl && \
    chown nobody /data/stats.xsl

COPY stats.xsl /data
COPY ./env/cameras.txt /data/


