FROM centos:7
MAINTAINER alan.ryan@jet.com
ENV CIDR "192.168.1.0/28"
ENV MAC_ID "B8:27:EB"

RUN yum -y update && yum clean all && \
    yum -y install git nmap jq && yum clean all

ADD entrypoint.sh .
CMD ["./entrypoint.sh"]

