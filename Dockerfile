FROM jupyter/base-notebook:latest

USER root

RUN apt-get update && \
    apt-get install -y build-essential \
        ruby2.5 ruby2.5-dev libzmq3-dev gnuplot-nox libgsl-dev libtool autoconf make \
        automake zlib1g-dev libsqlite3-dev libmagick++-dev imagemagick \
        libatlas-base-dev g++ libczmq-dev libffi-dev libtool-bin cmake git && \
        apt-get gnuplot-x11 clean

# See https://github.com/methodmissing/rbczmq/issues/64
RUN CPPFLAGS='-Wno-error=deprecated-declarations' gem install rbczmq -v '1.7.9'
RUN gem install nmatrix daru cztop iruby gnuplotrb gruff
RUN gem install specific_install
RUN gem specific_install https://github.com/SciRuby/daru.git
RUN gem install nyaplot
# RUN ls && ls && gem specific_install https://github.com/lokeshh/sciruby.git master

RUN gem install narray nmatrix gsl
RUN gem specific_install https://github.com/lokeshh/statsample-glm.git upgrade_daru
# RUN gem update --no-document --system && gem install --no-document sciruby-full

USER $NB_UID

RUN iruby register --force

COPY . .

ENTRYPOINT jupyter-notebook