#!/bin/sh

while getopts 'y' OPTION; do
  case $OPTION in
    y)
      export Y1="y"
      ;;
  esac
done
shift "$((OPTIND-1))"

echo "+ Git Remote"

export DEFAULT_ROOT="${HOME}/dropbox/dev/scripts"
source ${SCRIPT_DIR}/input-root/input-root.sh

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

while
[ "${ACTION}" != "add" ] &&
[ "${ACTION}" != "rename" ] &&
[ "${ACTION}" != "set-url" ]; do
  echo "Action: (add/rename/set-url):"
  read ACTION
done

if [ "${ACTION}" = "set-url" ] || [ "${ACTION}" = "add" ]; then
  while [ "${METHOD}" != "https" ] && [ "${METHOD}" != "ssh" ]; do
    echo "Method: (https/ssh)"
    read METHOD
  done
  while [ -z "${REMOTE}" ]; do
    echo "Remote: ([string]/interactive)"
    read REMOTE
  done
  while [ -z "${USERNAME}" ]; do
    echo "Username: ([string]/interactive)"
    read USERNAME
  done
  while [ "${REPO}" != "directory" ] && [ "${REPO}" != "interactive" ]; do
    echo "Repo: (directory/interactive)"
    read REPO
  done
fi

if [ "${ACTION}" = "rename" ]; then
  echo "Current Remote: ([string]/interactive)"
  read CURRENT_REMOTE
  echo "New Remote: ([string]/interactive)"
  read NEW_REMOTE
fi

while
[ "${CONFIRM}" != "y" ] &&
[ "${CONFIRM}" != "yes" ] &&
[ "${CONFIRM}" != "n" ] &&
[ "${CONFIRM}" != "no" ]; do
  echo "Root: ${ROOT}"
  echo "Depth: ${DEPTH}"
  echo "Run Directory: ${RUN_DIRECTORY}"
  echo "Action: ${ACTION}"
  if [ "${ACTION}" = "set-url" ] || [ "${ACTION}" = "add" ]; then
    echo "Method: ${METHOD}"
    echo "Remote: ${REMOTE}"
    echo "Username: ${USERNAME}"
    echo "Repo: ${REPO}"
  fi
  if [ "${ACTION}" = "rename" ]; then
    echo "Current Remote: ${CURRENT_REMOTE}"
    echo "New Remote: ${NEW_REMOTE}"
  fi
  echo "Confirm: (y/n)"
  read CONFIRM
done

[ -z "${DEPTH##*[[:digit:]]*}" ] && DEPTH=" -maxdepth ${DEPTH}"
[ "${DEPTH}" = "max" ] && DEPTH=

export_vars () {
  export RUN_DIRECTORY
  export METHOD
  export REMOTE
  export USERNAME
  export REPO
  export CURRENT_REMOTE
  export NEW_REMOTE
}

if [ "${CONFIRM}" = "y" ] || [ "${CONFIRM}" = "yes" ]; then
  export_vars
  if [ "${ACTION}" = "add" ]; then
    find "${ROOT}" -type d -name ".git"${DEPTH} -exec ${SCRIPT_DIR}/git-remote/git-remote-add.sh {} \;
  elif [ "${ACTION}" = "rename" ]; then
    find "${ROOT}" -type d -name ".git"${DEPTH} -exec ${SCRIPT_DIR}/git-remote/git-remote-rename.sh {} \;
  elif [ "${ACTION}" = "set-url" ]; then
    find "${ROOT}" -type d -name ".git"${DEPTH} -exec ${SCRIPT_DIR}/git-remote/git-remote-set-url.sh {} \;
  fi
else
  echo "Operation cancelled"
  exit 1
fi
