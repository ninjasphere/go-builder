FROM ubuntu:14.04
MAINTAINER jon@ninjablocks.com

RUN apt-get update -y && apt-get install -y git mercurial curl make gcc ruby-dev build-essential s3cmd

# docker
RUN curl -s https://get.docker.com/ | sh

# go
RUN cd /tmp && curl -sO https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
RUN gzip -dc /tmp/go1.4.2.linux-amd64.tar.gz | sudo tar -C /usr/local -xvf -
RUN rm /tmp/go1.4.2.linux-amd64.tar.gz

WORKDIR /usr/local/go/src

# build the linux, darwin and windows go tool chains
RUN GOOS=linux GOARCH=arm ./make.bash
RUN GOOS=darwin GOARCH=amd64 ./make.bash
RUN GOOS=windows GOARCH=amd64 ./make.bash

# install fpm
RUN gem install fpm

ADD scripts /scripts

VOLUME ["/data/go/bin", "/data/go/src", "/data/src", "/var/lib/docker", "/var/packages"]

ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /data/src
ENTRYPOINT ["/scripts/entry"]

