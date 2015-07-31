FROM ubuntu:14.04
MAINTAINER jon@ninjablocks.com

RUN apt-get update -y && apt-get install -y git mercurial curl make

# docker
RUN curl -s https://get.docker.com/ | sh

# go
RUN cd /tmp && curl -sO https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
RUN gzip -dc /tmp/go1.4.2.linux-amd64.tar.gz | sudo tar -C /usr/local -xvf -
RUN rm /tmp/go1.4.2.linux-amd64.tar.gz

ADD scripts /scripts

VOLUME ["/data/go/bin", "/data/go/src", "/data/src", "/var/lib/docker"]

ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /data/src
ENTRYPOINT ["/scripts/entry"]

