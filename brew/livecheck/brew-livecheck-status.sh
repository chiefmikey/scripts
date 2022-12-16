#!/bin/sh

LC_STATUS=$(screen -ls | grep livecheck | awk '{print $1}')

if [ -n "${LC_STATUS}" ]; then
  echo "Livecheck is running"
else
  echo "Livecheck is not running"
fi
