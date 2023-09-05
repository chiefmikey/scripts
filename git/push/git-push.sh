#!/bin/sh

while getopts 'y' OPTION; do
  case $OPTION in
    y)
      export Y1="y"
      ;;
  esac
done
shift "$((OPTIND-1))"

echo "+ Git Push"

export DEFAULT_ROOT="${HOME}/dropbox/dev/scripts"
source "${SCRIPT_DIR}"/input-root/input-root.sh

while [ -z "${DEPTH}" ]; do
  echo "Depth: ([integer], max)"
  read DEPTH
  if [ -n "${DEPTH}" ]; then
    if [ -z "${DEPTH##*[[:alpha:]]*}" ] && [ "${DEPTH}" != "max" ]; then
      echo "Invalid Depth"
      DEPTH=
    fi
    if [ -z "${DEPTH##*[[:digit:]]*}" ]; then
      if
      [ -z "${DEPTH##*[[:alpha:]]*}" ] ||
      [[ "${#DEPTH}" -gt 1 ]] &&
      [[ "${DEPTH}" = 0* ]]; then
        echo "Invalid Depth"
        DEPTH=
      fi
    fi
  fi
done

while [ "${RUN_DIRECTORY}" != "all" ] && [ "${RUN_DIRECTORY}" != "interactive" ]; do
  echo "Run Directory: (all/interactive)"
  read RUN_DIRECTORY
done

while [ -z "${REMOTE}" ]; do
  echo "Remote: ([string]/interactive)"
  read REMOTE
done

while [ -z "${BRANCH}" ]; do
  echo "Branch: ([string]/interactive)"
  read BRANCH
done

while
[ "${SET_UPSTREAM}" != "y" ] &&
[ "${SET_UPSTREAM}" != "yes" ] &&
[ "${SET_UPSTREAM}" != "n" ] &&
[ "${SET_UPSTREAM}" != "no" ]; do
  echo "set upstream: (y/n)"
  read SET_UPSTREAM
done

[ "${SET_UPSTREAM}" = "y" ] || [ "${SET_UPSTREAM}" = "yes" ] && SET_UPSTREAM="yes"

while
[ "${CONFIRM}" != "y" ] &&
[ "${CONFIRM}" != "yes" ] &&
[ "${CONFIRM}" != "n" ] &&
[ "${CONFIRM}" != "no" ]; do
  echo "Root: ${ROOT}"
  echo "Depth: ${DEPTH}"
  echo "Run Directory: ${RUN_DIRECTORY}"
  echo "Remote: ${REMOTE}"
  echo "Branch: ${BRANCH}"
  echo "Set Upstream: ${SET_UPSTREAM}"
  echo "Confirm: (y/n)"
  read CONFIRM
done

[ -z "${DEPTH##*[[:digit:]]*}" ] && DEPTH=" -maxdepth ${DEPTH}"
[ "${DEPTH}" = "max" ] && DEPTH=

export_vars () {
  export RUN_DIRECTORY
  export REMOTE
  export BRANCH
  export SET_UPSTREAM
}

if [ "${CONFIRM}" = "y" ] || [ "${CONFIRM}" = "yes" ]; then
  export_vars
  if [ "${RUN_DIRECTORY}" = "all" ]; then
    find "${ROOT}" -type d -name ".git""${DEPTH}" -exec "${SCRIPT_DIR}"/git-push/git-push-all.sh {} \;
  fi
else
  echo "operation cancelled"
  exit 1
fi
