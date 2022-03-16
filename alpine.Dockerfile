FROM alpine:latest AS base
MAINTAINER Xander Smeets <xander@smeets.re>
VOLUME ["/data"]
WORKDIR /data
ENV LATEXENGINE=lualatex
ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache texlive texlive-dvi texlive-luatex texlive-xetex texmf-dist-most xdvik py3-pygments git wget graphviz


FROM base AS no-lang
RUN luaotfload-tool --update


FROM base AS with-lang
RUN apk add --no-cache texlive-full
RUN luaotfload-tool --update
