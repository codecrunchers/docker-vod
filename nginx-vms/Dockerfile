FROM tiangolo/nginx-rtmp
EXPOSE 1935
COPY ./nginx.kepler.conf /etc/nginx/nginx.conf
VOLUME ["/data"]
CMD ["nginx", "-g", "daemon off;"]



