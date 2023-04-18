#!/bin/sh

LC_STATUS=$(screen -ls | grep livecheck | awk '{print $1}')

if [ -n "${LC_STATUS}" ]; then
  echo "livecheck is running"
else
  echo "livecheck is not running"
fi
