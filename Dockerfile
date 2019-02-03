FROM ruby:2.5.3
MAINTAINER Ben Guillet <benjamin.guillet@gmail.com>

ENV PG_MAJOR 9.6
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt-get update && \
  apt-get install -y postgresql-client-$PG_MAJOR vim nodejs gcc g++ make && \
  apt-get -q -y clean && \
  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN gem install bundler
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1


RUN mkdir -p /home/app
WORKDIR /home/app

COPY Gemfile /home/app/
COPY Gemfile.lock /home/app/

RUN bundle install --jobs 4 --retry 3

COPY . /home/app
CMD ["bundle", "exec", "rails", "console"]

