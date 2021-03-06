FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential mysql-client
RUN mkdir /app
WORKDIR /app

ADD . /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD . /app

EXPOSE 9292
