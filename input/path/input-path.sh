#!/bin/sh

while getopts 'd:n:' OPTION; do
  case $OPTION in
    d)
      if [ -n ${OPTARG} ]; then
        export TEMP_DEFAULT_PATH=${OPTARG/"~"/${HOME}}
        if [ -d ${TEMP_DEFAULT_PATH} ]; then
          export DEFAULT_PATH=${TEMP_DEFAULT_PATH}
        else
          echo "Invalid Default Path"
        fi
      else
        echo "Invalid Default Path"
      fi
      ;;
    n)
      if [ -n ${OPTARG} ]; then
        export PATH_NAME=${OPTARG}
      else
        echo "Invalid Path Name"
        export PATH_NAME="Path"
      fi
      ;;
  esac
done
shift "$((OPTIND-1))"

export PATH=${1}
if [ ! -n ${PATH_NAME} ]; then
  export PATH_NAME="Path"
fi

while
  [ -z ${PATH} ] ||
  [ ! -d ${PATH} ]; do
    if [ -z ${Y} ]; then
      export Y="undefined"
    fi
    if [ -z ${PATH} ]; then
      if [ -n ${DEFAULT_PATH} ]; then
        while
          [ ${Y} != "y" ] &&
          [ ${Y} != "yes" ] &&
          [ ${Y} != "n" ] &&
          [ ${Y} != "no" ]; do
            echo "+ Use Default ${PATH_NAME} (${DEFAULT_PATH})? [y/n]:"
            read Y
            if [ -z ${Y} ]; then
              export Y="undefined"
            fi
        done
      fi
      if [ ${Y} = "y" ] || [ ${Y} = "yes" ]; then
        export PATH=${DEFAULT_PATH}
      elif [ ${Y} = "n" ] || [ ${Y} = "no" ]; then
        echo "+ Input ${PATH_NAME}:"
        read PATH
        if [ -z ${PATH} ]; then
          export PATH="undefined"
        else
          export PATH=${PATH/"~"/${HOME}}
        fi
      fi
    fi
    if [ ! -d ${PATH} ]; then
      if [ ${PATH} != "undefined" ]; then
        echo "Invalid ${PATH_NAME}"
      fi
      echo "+ Input ${PATH_NAME}:"
      read PATH
      if [ -z ${PATH} ]; then
        export PATH="undefined"
      else
        export PATH=${PATH/"~"/${HOME}}
      fi
    fi
done
