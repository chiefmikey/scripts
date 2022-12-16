#!/bin/sh

export USER
export REPO
export URL="https://api.github.com/repos/${USER}/${REPO}/releases/latest"

export NO_PACKAGE=$(curl --silent ${URL} | jq ".. .message? // empty")

if [ -z ${NO_PACKAGE} ]; then
  export TAG_NAME=$(curl --silent ${URL} | jq ".. .tag_name? // empty")
  export OFFLINE=$(if [ -z ${TAG_NAME} ]; then echo "true"; fi)
fi

if [ -n ${NO_PACKAGE} ]; then echo "No package found for ${USER}/${REPO}"; fi
if [ -n ${TAG_NAME} ]; then echo ${TAG_NAME}; fi
if [ -n ${OFFLINE} ]; then echo "OFFLINE"; fi
