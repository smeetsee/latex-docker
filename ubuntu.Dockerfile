FROM ubuntu:jammy
MAINTAINER Xander Smeets <xander@smeets.re>

ARG DEBIAN_FRONTEND=noninteractive

ENV LATEXENGINE=lualatex
ENV PYTHONUNBUFFERED=1

ADD 01-nodoc.conf /etc/dpkg/dpkg.cfg.d/01-nodoc

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get remove -y --purge libzmq-dev python-dev libc-dev \
 && apt-get remove -y --purge gcc cpp binutils \
 && apt-get -y install \
        software-properties-common \
 && apt-get -y install \
        git \
        wget \
        graphviz \
        python3-pip \
        texlive-full \
        python-pygments \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

RUN luaotfload-tool --update

VOLUME ["/data"]
WORKDIR /data
