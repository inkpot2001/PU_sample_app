FROM ruby:3.0.1-alpine
ENV LANG C.UTF-8

ARG APP_ROOT=/app

ARG PACKAGES="build-base git mariadb-dev mariadb-client libxml2-dev libxslt-dev tzdata libsodium yaml yaml-dev zlib zlib-dev readline cairo-dev jpeg-dev giflib-dev g++ bash  file libpng libjpeg libgcc libgomp libpng-dev curl curl-dev make autoconf libc-dev libtool sqlite-dev redis nodejs"

RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.9/main" >> /etc/apk/repositories

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache $PACKAGES \
  && apk add --no-cache imagemagick \
  && apk add --no-cache imagemagick-dev \
  && apk add --no-cache less

RUN touch ~/.bashrc \
    && curl -o- -L https://yarnpkg.com/install.sh | bash \
    && ln -s "$HOME/.yarn/bin/yarn" /usr/local/bin/yarn

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile Gemfile.lock ./

RUN bundle config set force_ruby_platform true && \
    bundle install -j4

COPY . .