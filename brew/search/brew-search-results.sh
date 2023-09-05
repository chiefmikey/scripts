#!/bin/sh

CASK_FONTS=homebrew/cask-fonts
LINUXBREW_FONTS=homebrew/linux-fonts
CASK_VERSIONS=homebrew/cask-versions
BREW_CASK=homebrew/cask
BREW_CORE=homebrew/core
ALL_TAPS="${BREW_CASK} ${BREW_CORE} ${CASK_VERSIONS} ${LINUXBREW_FONTS} ${CASK_FONTS}"

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
