#!/bin/bash

cd ${1}/..
echo "+ Git Remote Rename"

export DIR_NAME=$(pwd | awk -F/ '{print $NF}')
echo ${DIR_NAME}

if [ "${RUN_DIRECTORY}" = "interactive" ]; then
  while
  [ "${INPUT_RUN_DIRECTORY}" != "y" ] &&
  [ "${INPUT_RUN_DIRECTORY}" != "yes" ] &&
  [ "${INPUT_RUN_DIRECTORY}" != "n" ] &&
  [ "${INPUT_RUN_DIRECTORY}" != "no" ]; do
    echo "Run Directory: (y/n)"
    read INPUT_RUN_DIRECTORY
  done
  [ "${INPUT_RUN_DIRECTORY}" = "y" ] || [ "${INPUT_RUN_DIRECTORY}" = "yes" ] && INPUT_RUN_DIRECTORY="yes"
else
  INPUT_RUN_DIRECTORY="yes"
fi

if [ "${INPUT_RUN_DIRECTORY}" = "yes" ]; then
  if [ "${CURRENT_REMOTE}" = "interactive" ]; then
    echo "Current Remote:"
    read INPUT_CURRENT_REMOTE
  else
    INPUT_CURRENT_REMOTE=${CURRENT_REMOTE}
  fi

  if [ "${NEW_REMOTE}" = "interactive" ]; then
    echo "New Remote:"
    read INPUT_NEW_REMOTE
  else
    INPUT_NEW_REMOTE=${NEW_REMOTE}
  fi

  echo "git remote rename ${INPUT_CURRENT_REMOTE} ${INPUT_NEW_REMOTE}"
  git remote rename ${INPUT_CURRENT_REMOTE} ${INPUT_NEW_REMOTE}
else
  echo "Skipped"
fi
