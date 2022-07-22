#!/bin/zsh

cd ${1}/..
echo "$(pwd | awk -F/ '{print $NF}'): $(git pull --rebase=false --autostash --no-edit)"
