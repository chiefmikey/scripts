#!/bin/sh

export SUDO_ASKPASS=${SCRIPT_DIR}/mac-sudo-askpass/mac-sudo-askpass.sh
cd ${HOME}

echo "+ Brew Update"
brew update

echo "+ Brew Upgrade"
brew upgrade --greedy

echo "+ Brew Cleanup"
brew cleanup -s

if [ "${1}" = "full" ]; then
  echo "+ rm brew --cache"
  rm -rf "$(brew --cache)"
fi
