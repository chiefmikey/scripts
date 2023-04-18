#!/bin/sh

while getopts 'c:d:f:' OPTION; do
  case $OPTION in
    c)
    # need to check if command is valid for shell
      if [ -n "${OPTARG}" ]; then
        INPUT_COMMAND=${OPTARG}
      else
        echo "Invalid Command"
      fi
      ;;
    d)
      if [ -n "${OPTARG}" ]; then
        if [ -d "${OPTARG}" ]; then
          ROOT=${OPTARG}
        else
          echo "Invalid Directory"
        fi
      else
        echo "Invalid Directory"
      fi
      ;;
    f)
    # need to check if file exists
      if [ -n "${OPTARG}" ]; then
        FILE=${OPTARG}
      else
        echo "Invalid File"
      fi
      ;;
  esac
done
shift "$((OPTIND-1))"

${INPUT_COMMAND} "${ROOT}"/"${FILE}"

DESC=${1}
echo "${DESC}"
