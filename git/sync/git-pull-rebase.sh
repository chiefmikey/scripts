#!/bin/sh

cd ${1}/..
export DIR_NAME=$(pwd | awk -F/ '{print $NF}')

echo "${DIR_NAME}: git pull --rebase=true --autostash --no-edit"
git pull --rebase=true --autostash --no-edit
