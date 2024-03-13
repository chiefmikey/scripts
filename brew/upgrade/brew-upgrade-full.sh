#!/bin/bash

# need to implement a check on this to see if it needs to be set or not. it errors out silently if it's already set.
export SUDO_ASKPASS="${SCRIPT_DIR}/mac/sudo-askpass/mac-sudo-askpass.sh"

cd "${HOME}" || exit

echo "+ brew update"
brew update

echo "+ brew upgrade"
brew upgrade --greedy

echo "+ brew cleanup"
brew cleanup -s

if [ "${1}" = "full" ]; then
  echo "+ rm brew --cache"
  rm -rf "$(brew --cache)"
fi
