#!/bin/sh

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

while [ "${CONFIRM}" != "y" ] && [ "${CONFIRM}" != "yes" ] &&
[ "${CONFIRM}" != "n" ] && [ "${CONFIRM}" != "no" ]; do
  echo "Root: ${ROOT}"
  echo "Confirm: (y/n)"
  read CONFIRM
done

if [ "${CONFIRM}" = "y" ] || [ "${CONFIRM}" = "yes" ]; then
  find ${ROOT} -type d -maxdepth 1 -exec ${SCRIPT_DIR}/git-init/git-init-init.sh {} \;
else
  echo "Operation cancelled"
  exit 1
fi
