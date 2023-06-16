FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y \
                       apt-utils \
                       tzdata \
                       libpq-dev \
                       nodejs

WORKDIR /app 

RUN gem install bundler -v 2.4.14

COPY Gemfile* ./

RUN bundle install

COPY . /app
