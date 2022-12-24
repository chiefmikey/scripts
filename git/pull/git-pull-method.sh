#!/bin/sh

while getopts 'd:' OPTION; do
  case $OPTION in
    d)
      if [ -n "${OPTARG}" ]; then
        export TEMP_DEFAULT_PULL_METHOD="${OPTARG}"
        if
          [ "${TEMP_DEFAULT_PULL_METHOD}" = "rebase" ] ||
          [ "${TEMP_DEFAULT_PULL_METHOD}" = "merge" ]; then
            export DEFAULT_PULL_METHOD="${TEMP_DEFAULT_PULL_METHOD}"
        else
          echo "Invalid Default Pull Method"
        fi
      else
        echo "Invalid Default Pull Method"
      fi
      ;;
    *)
      echo "Usage: git-pull-method [-d default-pull-method]"
      exit 1
      ;;
  esac
done

export PULL_METHOD="${1}"

while [ -z "${PULL_METHOD}" ]; do
  if [ -z "${Y}" ]; then
    export Y="undefined"
  fi
  if [ -n "${DEFAULT_PULL_METHOD}" ]; then
    while
      [ "${Y}" != "y" ] &&
      [ "${Y}" != "yes" ] &&
      [ "${Y}" != "n" ] &&
      [ "${Y}" != "no" ]; do
        echo "+ Use Default Pull Method (${DEFAULT_PULL_METHOD})? [y/n]:"
        read Y
        if [ -z "${Y}" ]; then
          export Y="undefined"
        fi
    done
  fi
  if [ "${Y}" = "y" ] || [ "${Y}" = "yes" ]; then
    export PULL_METHOD="${DEFAULT_PULL_METHOD}"
  elif [ "${Y}" = "n" ] || [ "${Y}" = "no" ]; then
    echo "+ Input Pull Method [rebase/merge]:"
    read PULL_METHOD
    if [ -z "${PULL_METHOD}" ]; then
      export PULL_METHOD="undefined"
    fi
  fi
done

while
  [ -n "${PULL_METHOD}" ] &&
  [ "${PULL_METHOD}" != "rebase" ] &&
  [ "${PULL_METHOD}" != "merge" ]; do
    if [ "${PULL_METHOD}" != "undefined" ]; then
      echo "Invalid Pull Method"
    fi
    echo "+ Input Pull Method [rebase/merge]:"
    read PULL_METHOD
    if [ -z "${PULL_METHOD}" ]; then
      export PULL_METHOD="undefined"
    fi
done

if [ -n "${PULL_METHOD}" ] &&
[ "${PULL_METHOD}" = "rebase" ] ||
[ "${PULL_METHOD}" = "merge" ]; then
  export PULL_METHOD="${PULL_METHOD}"
fi
