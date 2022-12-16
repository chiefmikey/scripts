#!/bin/sh

while getopts 'y' OPTION; do
  case $OPTION in
    y)
      export FLAG_CONFIRM="y"
      ;;
  esac
done
shift "$((OPTIND-1))"

INPUT_DIR=${1}
CHOWN_USER=${2}
CHOWN_GROUP=${3}
IS_RECURSIVE=${4}

if [ -n "${INPUT_DIR}" ] && [ -z "$FLAG_CONFIRM" ]; then
  echo "Directory: ${INPUT_DIR}"
  while \
  [ "${DIR_CONFIRM}" != "y" ] && \
  [ "${DIR_CONFIRM}" != "yes" ] && \
  [ "${DIR_CONFIRM}" != "n" ] && \
  [ "${DIR_CONFIRM}" != "no" ]; do
    echo "Confirm: (y/n)"
    read DIR_CONFIRM
  done
fi

[ "${DIR_CONFIRM}" = "n" ] || [ "${DIR_CONFIRM}" = "no" ] && INPUT_DIR=

while [ -z "${INPUT_DIR}" ] || [ ! -d "${INPUT_DIR}" ]; do
  if [ ! -d "${INPUT_DIR}" ]; then
    echo "Invalid Directory"
  fi
  echo "Directory:"
  read INPUT_DIR
done

if [ -n "${CHOWN_USER}" && [ -z "$FLAG_CONFIRM" ] ]; then
  echo "User: ${CHOWN_USER}"
  while \
  [ "${USER_CONFIRM}" != "y" ] && \
  [ "${USER_CONFIRM}" != "yes" ] && \
  [ "${USER_CONFIRM}" != "n" ] && \
  [ "${USER_CONFIRM}" != "no" ]; do
    echo "Confirm: (y/n)"
    read USER_CONFIRM
  done
fi

[ "${USER_CONFIRM}" = "n" ] || [ "${USER_CONFIRM}" = "no" ] && CHOWN_USER=

while [ -z "${CHOWN_USER}" ]; do
  echo "User:"
  read CHOWN_USER
done

if [ -n "${CHOWN_GROUP}" && [ -z "$FLAG_CONFIRM" ] ]; then
  echo "User: ${CHOWN_GROUP}"
  while \
  [ "${GROUP_CONFIRM}" != "y" ] && \
  [ "${GROUP_CONFIRM}" != "yes" ] && \
  [ "${GROUP_CONFIRM}" != "n" ] && \
  [ "${GROUP_CONFIRM}" != "no" ]; do
    echo "Confirm: (y/n)"
    read GROUP_CONFIRM
  done
fi

[ "${GROUP_CONFIRM}" = "n" ] || [ "${GROUP_CONFIRM}" = "no" ] && CHOWN_GROUP=

while [ -z "${CHOWN_GROUP}" ]; do
  echo "User:"
  read CHOWN_GROUP
done

if [ -n "${IS_RECURSIVE}" && [ -z "$FLAG_CONFIRM" ] ]; then
  echo "Recursive: yes"
  while \
  [ "${RECURSIVE_CONFIRM}" != "y" ] && \
  [ "${RECURSIVE_CONFIRM}" != "yes" ] && \
  [ "${RECURSIVE_CONFIRM}" != "n" ] && \
  [ "${RECURSIVE_CONFIRM}" != "no" ]; do
    echo "Confirm: (y/n)"
    read RECURSIVE_CONFIRM
  done
fi

[ "${RECURSIVE_CONFIRM}" = "n" ] || [ "${RECURSIVE_CONFIRM}" = "no" ] && IS_RECURSIVE=

while [ -z "${IS_RECURSIVE}" ]; do
  while \
  [ "${IS_RECURSIVE}" != "y" ] && \
  [ "${IS_RECURSIVE}" != "yes" ] && \
  [ "${IS_RECURSIVE}" != "n" ] && \
  [ "${IS_RECURSIVE}" != "no" ]; do
    echo "Recursive: (y/n)"
    read IS_RECURSIVE
  done
done

while \
[ "${SUBMIT_CONFIRM}" != "y" ] && \
[ "${SUBMIT_CONFIRM}" != "yes" ] && \
[ "${SUBMIT_CONFIRM}" != "n" ] && \
[ "${SUBMIT_CONFIRM}" != "no" ]; do
  echo "Directory: ${INPUT_DIR}"
  echo "User: ${CHOWN_USER}"
  echo "Group: ${CHOWN_GROUP}"
  echo "Recursive: ${IS_RECURSIVE}"

  echo "Confirm: (y/n)"
  read SUBMIT_CONFIRM
done

sudo chown -R "$USER":admin $INPUT_DIR