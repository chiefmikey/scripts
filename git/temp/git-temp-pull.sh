#!/bin/sh

BRANCH=$(git rev-parse --abbrev-ref HEAD)
TEMP_BRANCH="${BRANCH}_temp"
git pull origin "${TEMP_BRANCH}:${BRANCH}"
