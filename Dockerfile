ARG RUBY_VERSION=2.5.5
FROM ruby:${RUBY_VERSION}

RUN apt-get update
RUN apt-get install -y cron

RUN useradd -ms /bin/bash app

WORKDIR /app

COPY . /app

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
RUN chmod +x /wait

RUN mkdir storage
VOLUME storage

RUN chown -R app:app *

USER app

RUN gem install bundler
RUN bundle install
RUN bundle exec rake assets:precompile
RUN bundle exec whenever --update-crontab

ENV WAIT_HOSTS db:3306
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_ENV production
ENV TMPIMG_DB_USERNAME tmpimg
ENV TMPIMG_DB_PASS heyhey2013
ENV TMPIMG_DB_HOST db
RUN EDITOR="mate --wait" bundle exec rails credentials:edit

EXPOSE 3000

CMD  /wait && (bundle exec rails db:migrate; bundle exec rails server -p 3000 -b 0.0.0.0)
