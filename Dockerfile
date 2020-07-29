FROM ruby:2.6-alpine

WORKDIR /app
COPY . /app

ENV RAILS_ENV development

RUN apk add --no-cache --virtual .build-dependencies build-base && \
    apk add --no-cache nodejs postgresql-dev postgresql-client tzdata && \
    bundle install  && \
    apk del .build-dependencies


CMD ["rails","server","-b","0.0.0.0"]
