#!/bin/bash

cd ${1}/..
echo "+ Git Remote Add"

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
  if [ "${REMOTE}" = "interactive" ]; then
    echo "Remote:"
    read INPUT_REMOTE
  else
    INPUT_REMOTE=${REMOTE}
  fi

  if [ "${USERNAME}" = "interactive" ]; then
    echo "Remote:"
    read INPUT_USERNAME
  else
    INPUT_USERNAME=${USERNAME}
  fi

  if [ "${REPO}" = "directory" ]; then
    INPUT_REPO=${DIR_NAME}
  elif [ "${REPO}" = "interactive" ]; then
    echo "Repo:"
    read INPUT_REPO
  fi

  if [ "${METHOD}" = "ssh" ]; then
    echo "git remote add ${INPUT_REMOTE} git@github.com:${INPUT_USERNAME}/${INPUT_REPO}.git"
    git remote add ${INPUT_REMOTE} git@github.com:${INPUT_USERNAME}/${INPUT_REPO}.git
  fi

  if [ "${METHOD}" = "https" ]; then
    echo "git remote add ${INPUT_REMOTE} https://${INPUT_USERNAME}@github.com/${INPUT_USERNAME}/${INPUT_REPO}.git"
    git remote add ${INPUT_REMOTE} https://${INPUT_USERNAME}@github.com/${INPUT_USERNAME}/${INPUT_REPO}.git
  fi
else
  echo "Skipped"
fi
