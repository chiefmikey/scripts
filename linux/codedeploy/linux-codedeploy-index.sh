#!/bin/sh

export SCRIPT=${1}

if [ ! -n ${SCRIPT} ]; then
  echo "Choose OS [ubuntu/amazon]:"
  read SCRIPT
fi

if [ ${SCRIPT} == "amazon" ]; then
  ./upgrade/upgrade.sh
fi

if [ ${SCRIPT} == "ubuntu" ]; then
  ./dock-sort/dock-sort.sh
fi
