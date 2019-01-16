FROM jupyter/base-notebook:latest

USER root

RUN apt-get update && \
    apt-get install -y build-essential \
        ruby2.5 ruby2.5-dev libzmq3-dev gnuplot-nox libgsl-dev libtool autoconf make \
        automake zlib1g-dev libsqlite3-dev libmagick++-dev imagemagick \
        libatlas-base-dev g++ && \
        apt-get clean


RUN gem install daru nmatrix statsample cztop iruby 
# RUN gem update --no-document --system && gem install --no-document sciruby-full

USER $NB_UID

RUN iruby register --force

COPY . .