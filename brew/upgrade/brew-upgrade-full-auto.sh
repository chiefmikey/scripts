#!/bin/bash

export SUDO_ASKPASS="${SCRIPT_DIR}"/mac/sudo-askpass/mac-sudo-askpass.sh

brew autoupdate stop

echo "+ brew update"
BREW_UPDATE=$(brew update)
export BREW_UPDATE
if [ "${BREW_UPDATE}" = "already up to date." ]; then
  echo "already up to date."
else
  echo "${BREW_UPDATE}"
fi

echo "+ brew upgrade"
BREW_UPGRADE=$(brew upgrade --greedy)
export BREW_UPGRADE
if [ -z "${BREW_UPGRADE}" ]; then
  echo "already up to date."
else
  echo "${BREW_UPGRADE}"
fi

echo "+ brew cleanup"
BREW_CLEANUP=$(brew cleanup)
export BREW_CLEANUP
if [ -z "${BREW_CLEANUP}" ]; then
  echo "Cleanup complete."
else
  echo "${BREW_CLEANUP}"
fi

"${SCRIPT_DIR}"/brew-upgrade/brew-upgrade-autoupdate.sh "${1}"
