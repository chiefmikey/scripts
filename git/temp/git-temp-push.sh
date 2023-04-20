#!/bin/sh

BRANCH=$(git rev-parse --abbrev-ref HEAD)
TEMP_BRANCH="${BRANCH}_temp"
git push origin "${BRANCH}:${TEMP_BRANCH}" --force
