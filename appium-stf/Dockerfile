FROM vbanthia/appium-base:1.4.16
MAINTAINER Vishal Banthia <vishal.banthia.vb@gmail.com>

RUN apt-get update && apt-get install jq

COPY stf_helper /usr/local/bin/stf_helper


CMD [ "stf_helper.sh" ]
