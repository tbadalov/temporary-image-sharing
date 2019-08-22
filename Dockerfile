ARG RUBY_VERSION=2.5.5
FROM ruby:${RUBY_VERSION}

WORKDIR /app

COPY . /app

RUN gem install bundler
RUN bundle install

ENV RAILS_ENV production
ENV TMPIMG_DB_USERNAME tmpimg
ENV TMPIMG_DB_PASS heyhey2013
ENV TMPIMG_DB_HOST 172.17.0.1
RUN EDITOR="mate --wait" bin/rails credentials:edit

EXPOSE 3000

CMD bundle exec rails server -p 3000 -b 0.0.0.0
