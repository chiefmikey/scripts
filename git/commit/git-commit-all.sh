#!/bin/bash

cd ${1}
export DIR_NAME=$(pwd | awk -F/ '{print $NF}')

if [ $(pwd) != ${ROOT} ]; then
  echo "${DIR_NAME}: $(git add . && git commit -am "${MESSAGE}")"
fi
