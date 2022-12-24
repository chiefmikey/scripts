#!/bin/sh

cd "${1}"/.. || exit
echo "+ Git Pull Merge"

DIR_NAME=$(pwd | awk -F/ '{print $NF}')
export DIR_NAME
echo "${DIR_NAME}"

echo "${DIR_NAME}: git pull --rebase=false --autostash --no-edit"
git pull --rebase=false --autostash --no-edit
