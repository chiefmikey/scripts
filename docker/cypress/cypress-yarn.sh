#!/bin/sh

# Run yarn commands

# read package.json, match string containing "run: or "open: or "cy: etc, print full command up to " to "
# "${1}:${2}:${3}

# awk -F"|" 'BEGIN { OFS="|"} { print $3,$2,$1}' <(grep --line-buffered james divesh.txt)
# $ cat divesh.txt
# abdkfsj | kfjlds | james
# sdlfjk | sfdjsldfjk | andrew
# sdjfsdl | dskljoer | james

# $ awk -F"|" 'BEGIN { OFS="|"} { print $3,$2,$1}' <(grep --line-buffered james divesh.txt)
# james| kfjlds |abdkfsj
# james| dskljoer |sdjfsdl

export CMD="${1}"
export GROUP="${2}"
export ENV="${3}"
export LOCAL="${4}"
export TEST="${5}"

while [ -z "${INPUT}" ]; do
  echo "+ Input:"
  read INPUT
done

function check_env {
  if [ ! -z "${ENV}" ]; then
    if [ "${ENV}" = package.json ]; then
      export DIR="${LOCAL_DIR}"/package.json
      export DEST="${CONTAINER_DIR}"
    elif [ "${ENV}" = configs ]; then
      export DIR="${LOCAL_DIR}"/cypress/configs
      export DEST="${CONTAINER_DIR}"/cypress
    elif [ "${ENV}" = tests ]; then
      export DIR="${LOCAL_DIR}"/cypress/e2e
      export DEST="${CONTAINER_DIR}"/cypress
    elif [ "${ENV}" = directory ]; then
      export DIR="${LOCAL_DIR}"
      export DEST=/
    else
      echo "ERROR: Invalid environment"
      echo "+ Copy [package.json/configs/tests/directory]:"
      read ENV
      check_env
    fi
  fi
}

for CONTAINER_NAME in $(docker ps --format {{.Names}}); do
  if [ -z "${CONTAINER_NAME}" ]; then
    echo ERROR: No running containers
    exit 1
  fi
  docker exec -d "${CONTAINER_NAME}" yarn "${CMD}"${GROUP}"${ENV}"${LOCAL}"${TEST}"
done
