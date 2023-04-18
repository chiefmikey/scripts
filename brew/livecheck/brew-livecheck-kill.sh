#!/bin/sh

LIVECHECK_ID=$(screen -ls | grep livecheck | awk '{print $1}')

if [ -z "${LIVECHECK_ID}" ]; then
  echo "livecheck is not running"
else
  echo "kill screen: ${LIVECHECK_ID##*.}"
  screen -S "${LIVECHECK_ID%%.*}" -X quit
fi
