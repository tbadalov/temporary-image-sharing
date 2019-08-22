ARG RUBY_VERSION=2.5.5
FROM ruby:${RUBY_VERSION}

WORKDIR /app

COPY . /app

RUN gem install bundler
RUN gem install duktape -v '2.3.0.0' --source 'https://rubygems.org/'
RUN bundle install

RUN apt-get update && apt-get -y install apt-utils && apt-get upgrade -y && apt-get autoremove -y
RUN apt-get -y install net-tools

ENV RAILS_ENV production
ENV TMPIMG_DB_USERNAME tmpimg
ENV TMPIMG_DB_PASS heyhey2013
ENV TMPIMG_DB_HOST 172.17.0.1
RUN EDITOR="mate --wait" bundle exec rails credentials:edit

EXPOSE 3000

CMD bundle exec rails server -p 3000 -b 0.0.0.0
