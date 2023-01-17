#!/bin/sh

while getopts 's' OPTION; do
  case $OPTION in
    s)
      export FLAG_CONFIRM="y"
      ;;
    *)
      echo "Usage: mv [-s] <file> <file>"
      exit 1
      ;;
  esac
done
shift "$((OPTIND-1))"

if [ "${FLAG_CONFIRM}" = "y" ]; then
  if [ -e "${1}" ]; then
  mv "${1}" "${2}"
  echo "File is now ${2}"
  elif [ -e "${2}" ]; then
    echo "File is already ${2}"
  fi
elif [ -e "${1}" ]; then
  mv "${1}" "${2}"
  echo "File is now ${2}"
elif [ -e "${2}" ]; then
  mv "${2}" "${1}"
  echo "File is now ${1}"
fi
