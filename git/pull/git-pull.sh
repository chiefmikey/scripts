#!/bin/sh

while getopts 'y' OPTION; do
  case $OPTION in
    y)
      export Y1="y"
      export Y2="y"
      ;;
  esac
done
shift "$((OPTIND-1))"

export DEFAULT_ROOT="~/dropbox/dev"
export DEFAULT_PULL_METHOD="rebase"
export ROOT=${1}
export ROOT=${ROOT/"~"/${HOME}}
export DEFAULT_ROOT=${DEFAULT_ROOT/"~"/${HOME}}
export PULL_METHOD=${2}

export DEFAULT_ROOT="${HOME}/dropbox/dev/scripts"
source ${SCRIPT_DIR}/input-root/input-root.sh
source ${SCRIPT_DIR}/git-pull/git-pull-method.sh

while [ "${CONFIRM}" != "y" ] && [ "${CONFIRM}" != "yes" ] &&
[ "${CONFIRM}" != "n" ] && [ "${CONFIRM}" != "no" ]; do
  echo "Root: ${ROOT}"
  echo "Pull Method: ${PULL_METHOD}"
  echo "Confirm: [y/n]"
  read CONFIRM
done

if [ "${CONFIRM}" = "y" ] || [ "${CONFIRM}" = "yes" ]; then
  export ROOT=${ROOT}
  export PULL_METHOD=${PULL_METHOD}
  if [ "${PULL_METHOD}" = "rebase" ]; then
    find ${ROOT} -type d -name ".git" -exec ${SCRIPT_DIR}/git-pull/git-pull-rebase.sh {} \;
  elif [ "${PULL_METHOD}" = "merge" ]; then
    find ${ROOT} -type d -name ".git" -exec ${SCRIPT_DIR}/git-pull/git-pull-merge.sh {} \;
  fi
else
  echo "Operation cancelled"
  exit 1
fi
