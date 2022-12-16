#!/bin/sh

LIVECHECK_ID=$(screen -ls | grep livecheck | awk '{print $1}')

if [ -z "${LIVECHECK_ID}" ]; then
  echo "Livecheck is not running"
else
  echo "Kill screen: ${LIVECHECK_ID##*.}"
  screen -S ${LIVECHECK_ID%%.*} -X quit
fi
