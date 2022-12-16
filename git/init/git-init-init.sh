#!/bin/sh

cd ${1}
export DIR=$(pwd | awk -F/ '{print $NF}')
export GIT="./.git"

if [ $(pwd) != ${ROOT} ]; then
  if [ ! -d ${GIT} ]; then
    echo "${DIR}: $(git init)"
  else
    echo "${DIR}: Already a git repository"
  fi
fi
