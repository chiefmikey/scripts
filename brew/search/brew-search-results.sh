#!/bin/bash

BREW_CORE=homebrew/core
BREW_CASK=homebrew/cask
CASK_VERSIONS=homebrew/cask-versions
CASK_FONTS=homebrew/cask-fonts
ALL_TAPS="${BREW_CORE} ${BREW_CASK} ${CASK_VERSIONS} ${CASK_FONTS}"

package_counter () {
  COUNTER=0
  for cask in $("${SCRIPT_DIR}"/brew/search/brew-search.sh "${1}"); do
    COUNTER=$((${COUNTER} + 1))
  done
  echo "${COUNTER}"
}

for tap in ${ALL_TAPS}; do
  echo "${tap}: $(package_counter "${tap}")"
done
