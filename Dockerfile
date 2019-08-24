ARG RUBY_VERSION=2.5.5
FROM ruby:${RUBY_VERSION}

WORKDIR /app

COPY . /app

RUN gem install bundler
RUN bundle install
RUN bundle exec rake assets:precompile

ENV WAIT_HOSTS db:3306
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_ENV production
ENV TMPIMG_DB_USERNAME tmpimg
ENV TMPIMG_DB_PASS heyhey2013
ENV TMPIMG_DB_HOST db
RUN EDITOR="mate --wait" bundle exec rails credentials:edit

EXPOSE 3000

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
RUN chmod +x /wait

CMD  /wait && (bundle exec rails db:migrate; bundle exec rails server -p 3000 -b 0.0.0.0)
