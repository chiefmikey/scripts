#!/bin/sh

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
touch $CONTAINER_ALREADY_STARTED
  echo "-- First container startup --"
    apk update && apk upgrade
    apk add --no-cache \
      g++ \
      make \
      py3-pip \
      xvfb \
      nss-dev \
      zlib-dev \
      libffi-dev \
      openssl-dev \
      bzip2-dev \

      libatk1.0-0 \
      libatk-bridge2.0-0 \
      libgtk3.0 \
      libgbm1 \

      libasound2 \
      alsa-lib-dev \

      chromium \

      musl-dev

    # Install python
    mkdir /home/node
    wget -O /home/node/Python-3.9.13.tar.gz https://www.python.org/ftp/python/3.9.13/Python-3.9.13.tgz
    tar -xvzf /home/node/Python-3.9.13.tar.gz -C /home/node
    rm /home/node/Python-3.9.13.tar.gz
    
    cd /home/node/Python-3.9.13
    /home/node/Python-3.9.13/configure --enable-optimizations
    make
    make install

    # Install node
    wget -O /home/node/node-v16.6.1.tar.gz https://nodejs.org/download/release/v16.6.1/node-v16.6.1.tar.gz
    tar -xvzf /home/node/node-v16.6.1.tar.gz -C /home/node
    rm /home/node/node-v16.6.1.tar.gz
    cd /home/node/node-v16.6.1
    /home/node/node-v16.6.1/configure
    make
    make install
    /bin/sh

    # Install chrome
    wget -O /home/node/google-chrome-stable_current_amd64.deb \
      https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install /home/node/google-chrome-stable_current_amd64.deb

else
  echo "-- Not first container startup --"
    apt -y update && apt -y upgrade
    /bin/sh
fi
