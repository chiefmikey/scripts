#!/bin/sh

if [ -n "${1##*node_modules*node_modules*}" ]; then
  echo "${1}"
  xattr -w 'com.apple.fileprovider.ignore#P' 1 "${1}"
fi
