#!/bin/sh

wget -q --spider https://www.google.com

if [ $? -eq 0 ]; then
  echo "connected"
else
  echo "disconnected"
fi
