FROM vbanthia/appium-ruby:1.6.4
MAINTAINER Vishal Banthia <vishal.banthia.vb@gmail.com>

#==============================================================================
# Copied from https://github.com/docker-library/ruby/tree/master/2.2/onbuild
#=============================================================================

#===============================================================
# Throw errors if Gemfile has been modified since Gemfile.lock
#================================================================

RUN bundle config --global frozen 1

RUN mkdir -p /usr/src
WORKDIR /usr/src

ONBUILD COPY Gemfile /usr/src/
ONBUILD COPY Gemfile.lock /usr/src/
ONBUILD RUN bundle install

ONBUILD COPY . /usr/src
