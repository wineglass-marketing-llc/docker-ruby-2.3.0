# docker image for ruby 2.3.0 on alpine(linux os)
# by oran c(wisehackermonkey)
# email oranbusiness@gmail.com
# build ruby 2.3.0 from scrach because there is no avalible ruby=2.3.0 in the package manager
#https://github.com/cblunt/alpine-linux-ruby-dockerfile/blob/master/2.3.0/Dockerfile
FROM alpine:3.3
MAINTAINER Oran C <oranbusiness@gmail.com>
WORKDIR /

# 1 line to remove unnecessary build tools and reduce image size
RUN apk add --update linux-headers build-base openssl-dev libc-dev \
                     libxml2-dev libxslt-dev libffi-dev readline-dev \
                     jemalloc-dev git bash wget readline-dev nodejs nodejs-npm&& \

    wget -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz && \

    tar -xzvf ruby-install-0.6.0.tar.gz && \
    cd ruby-install-0.6.0/ && \
    make install && \

    ruby-install --system ruby 2.3.0 && \

    make uninstall && \
    cd / && rm -rf ruby-install-0.6.0 && \

    apk del bash wget linux-headers build-base openssl-dev libc-dev \
        libxml2-dev libxslt-dev libffi-dev \
        jemalloc-dev bash wget

RUN echo "gem: --no-document" > ~/.gemrc

RUN gem install bundler
RUN echo "Installed ruby version 2.3.0"