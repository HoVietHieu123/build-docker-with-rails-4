ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim

ARG NODE_MAJOR
ARG YARN_VERSION
SHELL ["/bin/bash", "-c"]

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    libsqlite3-dev \
    curl \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

RUN echo 'gem: --no-document' > /usr/local/etc/gemrc

WORKDIR /app

# Running bundle install
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# Create a directory for the app code
RUN mkdir -p /app
