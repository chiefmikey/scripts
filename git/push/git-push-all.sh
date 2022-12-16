#!/bin/sh

cd ${1}/..
echo "+ Git Push"

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
  if [ "${SET_UPSTREAM}" = "yes" ]; then
    INPUT_SET_UPSTREAM=" -u"
  else
    INPUT_SET_UPSTREAM=
  fi
  echo "git push${INPUT_SET_UPSTREAM} ${REMOTE} ${BRANCH}"
  PUSH_ALL=$(git push${INPUT_SET_UPSTREAM} ${REMOTE} ${BRANCH} 2>&1)
  if [ -z "${PUSH_ALL##*Repository not found.*}" ]; then
    echo "Repository not found."
    while
    [ "${INPUT_CREATE_REPOSITORY}" != "y" ] &&
    [ "${INPUT_CREATE_REPOSITORY}" != "yes" ] &&
    [ "${INPUT_CREATE_REPOSITORY}" != "n" ] &&
    [ "${INPUT_CREATE_REPOSITORY}" != "no" ]; do
      echo "Create Repository: (y/n)"
      read INPUT_CREATE_REPOSITORY
    done
    if [ "${INPUT_CREATE_REPOSITORY}" = "y" ] || [ "${INPUT_CREATE_REPOSITORY}" = "yes" ]; then
      ${SCRIPT_DIR}/gh-repo/gh-repo-create.sh
    fi
  else
    echo ${PUSH_ALL}
  fi
else
  echo "Skipped"
fi
