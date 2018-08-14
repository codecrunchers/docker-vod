FROM centos:7
MAINTAINER alan.ryan@jet.com

RUN yum -y update && yum clean all && \
    yum -y install git nmap && yum clean all

WORKDIR /app
ADD ./src/app /app/
ENTRYPOINT ["./app"]
