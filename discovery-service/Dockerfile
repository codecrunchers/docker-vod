FROM centos:7
MAINTAINER alan.ryan@jet.com

RUN yum -y update && yum clean all && \
    yum -y install git nmap jq && yum clean all

ADD entrypoint.sh .
CMD ["./entrypoint.sh"]

