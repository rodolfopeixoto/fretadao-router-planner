FROM ruby:2.7.0-alpine3.11

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                tzdata \
                                mysql-dev                              

RUN apk add --no-cache yarn --repository="http://dl-cdn.alpinelinux.org/alpine/edge/community" 
RUN yarn -v

ENV APP_PATH /app

# Different layer for gems installation
WORKDIR $APP_PATH
ADD Gemfile $APP_PATH
ADD Gemfile.lock $APP_PATH
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

# Copy the application into the container
COPY . APP_PATH
EXPOSE 3000