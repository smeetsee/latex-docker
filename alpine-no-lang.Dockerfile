FROM alpine:latest
MAINTAINER Xander Smeets <xander@smeets.re>

#ARG DEBIAN_FRONTEND=noninteractive

ENV LATEXENGINE=lualatex
ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache texlive texlive-dvi texlive-luatex texlive-xetex texmf-dist-most xdvik py3-pygments git wget graphviz

RUN luaotfload-tool --update

VOLUME ["/data"]
WORKDIR /data
