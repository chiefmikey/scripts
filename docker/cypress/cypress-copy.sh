#!/bin/sh

# Copy local cypress files to running docker containers

export LOCAL_DIR="${HOME}"/dropbox/dev/apps/cypress_framework
export CONTAINER_DIR=/cypress_framework
export INPUT="${1}"
export DIR="Input"

function check_input {
  if [ ! -z "${INPUT}" ]; then
    if [ "${INPUT}" = package.json ]; then
      export DIR="${LOCAL_DIR}"/package.json
      export DEST=${CONTAINER_DIR}
    elif [ "${INPUT}" = configs ]; then
      export DIR="${LOCAL_DIR}"/cypress/configs
      export DEST=${CONTAINER_DIR}/cypress
    elif [ "${INPUT}" = tests ]; then
      export DIR="${LOCAL_DIR}"/cypress/e2e
      export DEST=${CONTAINER_DIR}/cypress
    elif [ "${INPUT}" = directory ]; then
      export DIR="${LOCAL_DIR}"
      export DEST=/
    else
      echo "ERROR: Invalid input"
      echo "+ Copy [package.json/configs/tests/directory]:"
      read INPUT
      check_input
    fi
    if [ "${INPUT}" != package.json ] && [ ! -d "${DIR}" ]; then
      echo ERROR: "${DIR}" does not exist
      exit 1
    fi
  fi
}

while [ -z "${INPUT}" ]; do
  echo "+ Copy [package.json/configs/tests/directory]:"
  read INPUT
  check_input
done

for CONTAINER_NAME in $(docker ps --format {{.Names}}); do
  if [ -z "${CONTAINER_NAME}" ]; then
    echo ERROR: No running containers
    exit 1
  fi
  docker cp "${DIR}" "${CONTAINER_NAME}":"${DEST}"
done
