#!/bin/sh

cd "${1}" || exit
DIR=$(pwd | awk -F/ '{print $NF}')
export DIR
export GIT="./.git"

if [ "$(pwd)" != "${ROOT}" ]; then
  if [ ! -d ${GIT} ]; then
    echo "${DIR}: $(git init)"
  else
    echo "${DIR}: already a git repository"
  fi
fi
