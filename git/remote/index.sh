#!/bin/bash

if [ ! -d "./modules" ]; then mkdir "./modules"; fi
if [ -f "./modules/script-manager.sh" ]; then
  touch "./modules/script-manager.sh"
  export URL="https://api.github.com/repos/chiefmikey/script-manager/releases/latest"
  export TARBALL=$(curl -O --silent ${URL} | jq ".. .tarball_url? // empty")
  if [ -z ${TARBALL} ]; then
    echo "Offline"
    exit 1
  else
    curl -O --silent ${TARBALL}
    tar -xvf script-manager.tar.gz
    rm script-manager.tar.gz
    mv script-manager.sh modules/
  fi
fi

if [ -n SCR]; then
fi


if [ -z ${NO_PACKAGE} ]; then
  export TAG_NAME=$(curl --silent ${URL} | jq ".. .tag_name? // empty")
  export OFFLINE=$(if [ -z ${TAG_NAME} ]; then echo "true"; fi)
fi

if [ -n ${NO_PACKAGE} ]; then echo "No package found for ${USER}/${REPO}"; fi
if [ -n ${TAG_NAME} ]; then echo ${TAG_NAME}; fi
if [ -n ${OFFLINE} ]; then echo "OFFLINE"; fi
