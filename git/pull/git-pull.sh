#!/bin/bash

while getopts 'y' OPTION; do
  case $OPTION in
    y)
      export Y1="y"
      export Y2="y"
      ;;
    *)
      echo "Usage: git-pull [-y]"
      exit 1
      ;;
  esac
done
shift "$((OPTIND-1))"

if [ -z "${SCRIPT_DIR}" ]; then
  export DEFAULT_SCRIPT_DIR="${HOME}/dropbox/dev/tales-from-the-script"
else
  export DEFAULT_SCRIPT_DIR="${SCRIPT_DIR}"
fi

export DEFAULT_ROOT="${HOME}/dropbox/dev"
export DEFAULT_PULL_METHOD="rebase"
export INPUT_ROOT="${1}"
FORMAT_INPUT_ROOT="$(echo "${INPUT_ROOT}" | sed "s/~/${HOME}/g")"
export FORMAT_INPUT_ROOT
FORMAT_DEFAULT_ROOT="$(echo "${DEFAULT_ROOT}" | sed "s/~/${HOME}/g")"
export FORMAT_DEFAULT_ROOT

export PULL_METHOD="${2}"

"${DEFAULT_SCRIPT_DIR}"/input/root/input-root.sh
"${DEFAULT_SCRIPT_DIR}"/git/pull/git-pull-method.sh

while [ "${CONFIRM}" != "y" ] && [ "${CONFIRM}" != "yes" ] &&
[ "${CONFIRM}" != "n" ] && [ "${CONFIRM}" != "no" ]; do
  echo "Root: ${ROOT}"
  echo "Pull Method: ${PULL_METHOD}"
  echo "Confirm: [y/n]"
  read CONFIRM
done

if [ "${CONFIRM}" = "y" ] || [ "${CONFIRM}" = "yes" ]; then
  export ROOT="${ROOT}"
  export PULL_METHOD="${PULL_METHOD}"
  if [ "${PULL_METHOD}" = "rebase" ]; then
    find "${ROOT}" -type d -name ".git" -exec "${DEFAULT_SCRIPT_DIR}"/git-pull/git-pull-rebase.sh {} \;
  elif [ "${PULL_METHOD}" = "merge" ]; then
    find "${ROOT}" -type d -name ".git" -exec "${DEFAULT_SCRIPT_DIR}"/git-pull/git-pull-merge.sh {} \;
  fi
else
  echo "Operation cancelled"
  exit 1
fi
