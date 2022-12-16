#!/bin/sh

# Copy cypress artifacts from running docker containers

export ROOT_DIR=${HOME}/dropbox/dev/apps
export DIR_NAME=artifacts
export VIDEOS_DIR=/cypress_framework/cypress/videos
export SCREENSHOTS_DIR=/cypress_framework/cypress/screenshots
export LOGS_DIR=/cypress_framework/cypress/logs
export CURRENT_DATE=$(TZ=:US/Mountain date +%m-%d-%y:%H-%M-%S)

export INPUT_DESC=${1}
if [ ! -z ${INPUT_DESC} ]; then
  export DESC=_${INPUT_DESC}
else
  echo + Description [run/open/test/local/etc]:
  read INPUT_DESC
  if [ ! -z ${INPUT_DESC} ]; then
    export DESC=_${INPUT_DESC}
  fi
fi

if [ ! -d ${ROOT_DIR} ]; then
  echo ERROR: ${ROOT_DIR} does not exist
  exit 1
fi

export TARGET_DIR=${ROOT_DIR}/${DIR_NAME}
if [ ! -d ${TARGET_DIR} ]; then
  mkdir ${TARGET_DIR}
fi

export DEST_DIR=${TARGET_DIR}/${CURRENT_DATE}${DESC}
if [ -d ${DEST_DIR} ]; then
  echo ERROR: ${DEST_DIR} already exists
  exit 1
else
  mkdir ${DEST_DIR}
fi

for CONTAINER_NAME in $(docker ps --format {{.Names}}); do
  if [ -z ${CONTAINER_NAME} ]; then
    echo ERROR: No running containers
    exit 1
  fi
  OUTPUT_DIR=${DEST_DIR}/${CONTAINER_NAME}
  mkdir ${OUTPUT_DIR}
  docker cp ${CONTAINER_NAME}:${VIDEOS_DIR} ${OUTPUT_DIR}
  docker cp ${CONTAINER_NAME}:${SCREENSHOTS_DIR} ${OUTPUT_DIR}
  docker cp ${CONTAINER_NAME}:${LOGS_DIR} ${OUTPUT_DIR}
  docker exec -d ${CONTAINER_NAME} rm -rf ${VIDEOS_DIR} ${SCREENSHOTS_DIR} ${LOGS_DIR}
done
