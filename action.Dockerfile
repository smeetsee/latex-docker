FROM ubuntu:noble
MAINTAINER Xander Smeets <xander@smeets.ee>

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
        python3-pygments \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

RUN luaotfload-tool --update

VOLUME ["/data"]
WORKDIR /data

# Set the working directory inside the container
WORKDIR /usr/src

# Copy any source file(s) required for the action
COPY entrypoint.sh .

# Make entrypoint executable
RUN chmod +x /usr/src/entrypoint.sh

# Configure the container to be run as an executable
ENTRYPOINT ["/usr/src/entrypoint.sh"]