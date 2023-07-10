#! /bin/bash

while getopts 'q' OPTION; do
  case ${OPTION} in
    q)
      QUIET="y"
      ;;
    *)
      BAD_FLAGS=
      for flag in "${@}"; do
        [ -n "${FLAG_LIST##*"${flag##*-}"*}" ] && BAD_FLAGS="${BAD_FLAGS} ${flag}"
      done
      echo "Invalid flags:${BAD_FLAGS}"
      exit 1
      ;;
  esac
done

CASK_FONTS=homebrew/cask-fonts
LINUXBREW_FONTS=homebrew/linux-fonts
CASK_VERSIONS=homebrew/cask-versions
BREW_CASK=homebrew/cask
BREW_CORE=homebrew/core
ALL_TAPS="${BREW_CASK} ${BREW_CORE} ${CASK_VERSIONS} ${LINUXBREW_FONTS} ${CASK_FONTS}"

echo + reset taps to master
for tap in ${ALL_TAPS}; do
  [ "${QUIET}" != "y" ] && echo "+ resetting ${tap} to git master"
  git -C "$(brew --repo "${tap}")" reset --hard origin/master --quiet
done

# list all available brew taps including core and cask
# brew tap-info --json=v1 --installed | jq -r '.[] | .name' | sort -u
