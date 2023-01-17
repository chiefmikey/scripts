#!/bin/sh

if [ -n "${1##*node_modules*node_modules*}" ]; then
  echo "${1}"
  xattr -w com.dropbox.ignored 1 "${1}"
fi
