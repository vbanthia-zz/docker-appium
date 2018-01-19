FROM vbanthia/appium-ruby:1.7.2
MAINTAINER Vishal Banthia <vishal.banthia.vb@gmail.com>

RUN apt-get update && apt-get install -y jq

COPY ./stf_helper /usr/local/bin/stf_helper


CMD [ "stf_helper.sh" ]
