#!/bin/bash

cd "${1}"/.. || exit
DIR_NAME=$(pwd | awk -F/ '{print $NF}')
export DIR_NAME

echo "${DIR_NAME}: git pull --rebase=true --autostash --no-edit"
git pull --rebase=true --autostash --no-edit
