#!/bin/sh

export SUDO_ASKPASS="${SCRIPT_DIR}"/mac/sudo-askpass/mac-sudo-askpass.sh

brew autoupdate stop

echo "+ Brew Update"
BREW_UPDATE=$(brew update)
export BREW_UPDATE
if [ "${BREW_UPDATE}" = "Already up-to-date." ]; then
  echo "Already up-to-date."
else
  echo "${BREW_UPDATE}"
fi

echo "+ Brew Upgrade"
BREW_UPGRADE=$(brew upgrade --greedy)
export BREW_UPGRADE
if [ -z "${BREW_UPGRADE}" ]; then
  echo "Already up-to-date."
else
  echo "${BREW_UPGRADE}"
fi

echo "+ Brew Cleanup"
BREW_CLEANUP=$(brew cleanup)
export BREW_CLEANUP
if [ -z "${BREW_CLEANUP}" ]; then
  echo "Cleanup complete."
else
  echo "${BREW_CLEANUP}"
fi

"${SCRIPT_DIR}"/brew-upgrade/brew-upgrade-autoupdate.sh "${1}"
