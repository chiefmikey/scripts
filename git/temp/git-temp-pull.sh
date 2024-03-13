#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
TEMP_BRANCH="${BRANCH}_temp"
git fetch origin "${TEMP_BRANCH}"
git reset --hard "origin/${TEMP_BRANCH}"
