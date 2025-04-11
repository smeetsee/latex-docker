FROM ubuntu:noble
MAINTAINER Xander Smeets <xander@smeets.ee>

ARG DEBIAN_FRONTEND=noninteractive

ENV LATEXENGINE=lualatex
ENV PYTHONUNBUFFERED=1

ADD 01-nodoc.conf /etc/dpkg/dpkg.cfg.d/01-nodoc

RUN apt-get -y update \
 && apt-mark purge libzmq-dev python-dev libc-dev gcc cpp binutils \
 && apt-mark install software-properties-common git wget graphviz python3-pip texlive-full python3-pygments \
 && apt-get -y dselect-upgrade \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

RUN luaotfload-tool --update

VOLUME ["/data"]
WORKDIR /data
