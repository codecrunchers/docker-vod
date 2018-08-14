#FROM tiangolo/nginx-rtmp
FROM buildpack-deps:stretch

LABEL maintainer="Sebastian Ramirez <tiangolo@gmail.com>"
LABEL maintainer="Alan Ryan <kepler@jet.com>"

# Versions of Nginx and nginx-rtmp-module to use
ENV NGINX_VERSION nginx-1.15.0
ENV NGINX_RTMP_MODULE_VERSION dev

# Install dependencies
RUN apt-get update && \
    apt-get install -y ca-certificates openssl libssl-dev unzip && \
    rm -rf /var/lib/apt/lists/*

# Download and decompress Nginx
RUN mkdir -p /tmp/build/nginx && \
    cd /tmp/build/nginx && \
    wget -O ${NGINX_VERSION}.tar.gz https://nginx.org/download/${NGINX_VERSION}.tar.gz && \
    tar -zxf ${NGINX_VERSION}.tar.gz

# Download and decompress RTMP module
RUN mkdir -p /tmp/build/nginx-rtmp-module && \
    cd /tmp/build/nginx-rtmp-module && \
    wget -O nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}.zip https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/dev.zip && \
    unzip nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}.zip && \
    cd nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}

# Build and install Nginx
# The default puts everything under /usr/local/nginx, so it's needed to change
# it explicitly. Not just for order but to have it in the PATH
RUN cd /tmp/build/nginx/${NGINX_VERSION} && \
    ./configure \
        --sbin-path=/usr/local/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --pid-path=/var/run/nginx/nginx.pid \
        --lock-path=/var/lock/nginx/nginx.lock \
        --http-log-path=/var/log/nginx/access.log \
        --http-client-body-temp-path=/tmp/nginx-client-body \
        --with-http_ssl_module \
        --with-threads \
        --with-ipv6 \
        --add-module=/tmp/build/nginx-rtmp-module/nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} && \
    make -j $(getconf _NPROCESSORS_ONLN) && \
    make install && \
    mkdir /var/lock/nginx && \
    rm -rf /tmp/build

# Forward logs to Docker
RUN mkdir /scripts
COPY scripts/*.sh /scripts/

# Set up config file
COPY ./nginx.kepler.conf /etc/nginx/nginx.conf
#COPY ./crossdomain.xml /usr/local/nginx/html/
COPY ./stats.xsl /usr/local/nginx/html/
#COPY ./dash.js /usr/local/nginx/html/
#COPY ./index.html /usr/local/nginx/html/




VOLUME ["/data"]


EXPOSE 1935
CMD ["nginx", "-g", "daemon off;"]
