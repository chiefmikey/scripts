#!/bin/sh

export USER="${1}"
export REPO="${2}"

export CURRENT_VERSION=curl --silent "https://api.github.com/repos/${USER}/${REPO}/releases/latest" | jq ".. .tag_name? // empty"

echo "${CURRENT_VERSION}"
