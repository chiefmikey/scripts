#!/bin/bash

while getopts 'y' OPTION; do
  case $OPTION in
    y)
      export Y1="y"
      ;;
  esac
done
shift "$((OPTIND-1))"

export DEFAULT_ROOT="${HOME}/dropbox/dev/scripts"
source ${SCRIPT_DIR}/input-root/input-root.sh

# add interactive
while [ "${ACTION}" != "all" ] &&
[ "${ACTION}" != "all" ] &&
[ "${ACTION}" != "all" ]; do
  echo "(all):"
  read ACTION
done

# add interactive
while [ -z "${MESSAGE}" ]; do
  echo "Commit message:"
  read MESSAGE
done

while [ "${CONFIRM}" != "y" ] && [ "${CONFIRM}" != "yes" ] &&
[ "${CONFIRM}" != "n" ] && [ "${CONFIRM}" != "no" ]; do
  echo "Root: ${ROOT}"
  echo "Action: ${ACTION}"
  echo "Message: ${MESSAGE}"
  echo "Confirm: (y/n)"
  read CONFIRM
done

if [ "${CONFIRM}" = "y" ] || [ "${CONFIRM}" = "yes" ]; then
  export MESSAGE=${MESSAGE}
  if [ "${ACTION}" = "all" ]; then
    find ${ROOT} -type d -maxdepth 1 -exec ${SCRIPT_DIR}/git-commit/git-commit-all.sh {} \;
  fi
else
  echo "Operation cancelled"
  exit 1
fi
