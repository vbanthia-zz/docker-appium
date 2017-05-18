FROM ubuntu:16.04
MAINTAINER Vishal Banthia <vishal.banthia.vb@gmail.com>

#=================================
# Customize sources for apt-get
#=================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list

#=============================================
# Install Android SDK's and Platform tools
#=============================================
RUN export DEBIAN_FRONTEND=noninteractive \
  && dpkg --add-architecture i386 \
  && apt-get update -y \
  && apt-get -y --no-install-recommends install \
    libc6-i386 \
    lib32stdc++6 \
    lib32gcc1 \
    lib32ncurses5 \
    lib32z1 \
    wget \
    curl \
    unzip \
    git \
    openjdk-8-jdk \
  && mkdir -p /opt/android-sdk \
  && wget --progress=dot:giga -O /opt/android-sdk/sdk-tools.zip \
    https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
  && unzip /opt/android-sdk/sdk-tools.zip -d /opt/android-sdk \
  && rm /opt/android-sdk/sdk-tools.zip

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN mkdir -p -m 0750 /root/.android
ADD files/insecure_shared_adbkey /root/.android/adbkey
ADD files/insecure_shared_adbkey.pub /root/.android/adbkey.pub

RUN echo y | /opt/android-sdk/tools/bin/sdkmanager "platforms;android-25" "build-tools;25.0.3" "platform-tools" \
  && apt-get -qqy clean \
  && rm -rf /var/cache/apt/*

#================================
# Set up PATH for Android Tools
#================================

ENV PATH $PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools
ENV ANDROID_HOME /opt/android-sdk

#==========================
# Install Appium Dependencies
#==========================
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get -qqy install \
    nodejs \
    python \
    make \
    build-essential \
    g++

#=====================
# Install Appium
#=====================
ENV APPIUM_VERSION 1.6.4

RUN mkdir /opt/appium \
  && cd /opt/appium \
  && npm install appium@$APPIUM_VERSION \
  && ln -s /opt/appium/node_modules/.bin/appium /usr/bin/appium

#==================================================
# Export Appium, Bootstrap and Chromedriver Ports
#==================================================
EXPOSE 4723
EXPOSE 4724
EXPOSE 9515

#==========================
# Run appium as default
#==========================
CMD /usr/bin/appium
