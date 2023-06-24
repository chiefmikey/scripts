#! /bin/bash

CASK_FONTS=homebrew/cask-fonts
LINUXBREW_FONTS=homebrew/linux-fonts
CASK_VERSIONS=homebrew/cask-versions
BREW_CASK=homebrew/cask
BREW_CORE=homebrew/core
ALL_TAPS="${BREW_CASK} ${BREW_CORE} ${CASK_VERSIONS} ${LINUXBREW_FONTS} ${CASK_FONTS}"

# reset all taps to git master
for tap in ${ALL_TAPS}; do
  echo "+ resetting ${tap} to git master"
  git -C "$(brew --repo "${tap}")" reset --hard origin/master
done

# list all available brew taps including core and cask
# brew tap-info --json=v1 --installed | jq -r '.[] | .name' | sort -u
