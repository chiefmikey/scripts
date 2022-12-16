#!/bin/sh

cd ${1}/..
echo "+ Git Pull Merge"

export DIR_NAME=$(pwd | awk -F/ '{print $NF}')
echo ${DIR_NAME}

echo "${DIR_NAME}: git pull --rebase=false --autostash --no-edit"
git pull --rebase=false --autostash --no-edit
