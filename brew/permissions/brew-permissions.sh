#!/bin/bash

BREW_DIR="$(brew --prefix)/Cellar/*"

${SCRIPT_DIR}/input-chown/input-chown.sh ${BREW_DIR}
