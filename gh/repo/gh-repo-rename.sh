#!/bin/sh

cd ${1}/..
echo "+ GH Repo Rename"

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

  if [ "${REPO}" = "directory" ]; then
    INPUT_TARGET_REPO=
  elif [ "${REPO}" = "interactive" ]; then
    while [ -z "${INPUT_REPO}" ]; do
      echo "Repo:"
      read INPUT_REPO
    done
    while [ -z "${INPUT_USERNAME}" ]; do
      echo "Username:"
      read INPUT_USERNAME
    done
    INPUT_TARGET_REPO="--repo ${INPUT_USERNAME}/${INPUT_REPO} "
  fi

  if [ "${NEW_NAME}" = "directory" ]; then
    INPUT_NEW_NAME=${DIR_NAME}
  elif [ "${NEW_NAME}" = "interactive" ]; then
    while [ -z "${INPUT_NEW_NAME}" ]; do
      echo "New Name:"
      read INPUT_NEW_NAME
    done
  fi

  echo "gh repo rename ${INPUT_NEW_NAME} ${INPUT_TARGET_REPO}--confirm"
  gh repo rename ${INPUT_NEW_NAME} ${INPUT_TARGET_REPO}--confirm

else
  echo "Skipped"
fi
