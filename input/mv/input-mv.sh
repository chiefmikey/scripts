#!/bin/sh

while getopts 's' OPTION; do
  case $OPTION in
    s)
      export FLAG_CONFIRM="y"
      ;;
  esac
done
shift "$((OPTIND-1))"

if [ "${FLAG_CONFIRM}" = "y" ]; then
  if [ -e ${1} ]; then
  mv ${1} ${2}
  echo "File is now e.eslintrc.js"
  elif [ -e ${2} ]; then
    echo "File is already e.eslintrc.js"
  fi
elif [ -e ${1} ]; then
  mv ${1} ${2}
  echo "File is now e.eslintrc.js"
elif [ -e ${2} ]; then
  mv ${2} ${1}
  echo "File is now .eslintrc.js"
fi
