#!/bin/sh

echo "+ brew livecheck"
cd "${HOME}" || exit

FLAG_LIST="baloskdrft"
while getopts 'baloskdrft:' OPTION; do
  case ${OPTION} in
    b)
      LC_BUMP="-b"
      FLAG_REDUCER="${FLAG_REDUCER} -b "
      ;;
    a)
      LC_ALL="y"
      FLAG_REDUCER="${FLAG_REDUCER} -a "
      ;;
    l)
      LC_LOCAL="y"
      ;;
    o)
      LC_LOCAL_SCREEN="y"
      ;;
    s)
      LC_STATUS="y"
      ;;
    k)
      LC_KILL="y"
      ;;
    d)
      LC_SCREEN="screen -S livecheck -dm"
      echo + "detached: livecheck"
      ;;
    r)
      RESET_GIT="y"
      ;;
    f)
      FORMAT_LOGS="y"
      ;;
    t)
      LC_DELAY="-t ${OPTARG}"
      echo + "delay: ${OPTARG} seconds"
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
shift "$((OPTIND-1))"

[ "${RESET_GIT}" = "y" ] && "${SCRIPT_DIR}"/brew/reset/brew-reset.sh

LOG_DIR="${SCRIPT_DIR}/brew/livecheck/log"
LOG_LOG="${LOG_DIR}/brew-livecheck-log.log"
LOG_ERROR="${LOG_DIR}/brew-livecheck-error.log"
LOG_HEALTH="${LOG_DIR}/brew-livecheck-health.log"
LOG_HISTORY="${LOG_DIR}/brew-livecheck-history.log"
LOG_UPGRADE="${LOG_DIR}/brew-livecheck-upgrade.log"
LOG_FILES="${LOG_LOG} ${LOG_ERROR} ${LOG_HEALTH} ${LOG_HISTORY} ${LOG_UPGRADE}"

format_logs () {
  for file in ${LOG_FILES}; do
    echo "" > "${file}"
  done
}

if [ "${FORMAT_LOGS}" = "y" ]; then
  echo + "formatting logs"
  format_logs
fi

verify_logs () {
  if [ ! -d "${LOG_DIR}" ]; then
    mkdir "${LOG_DIR}"
  fi

  for file in ${LOG_FILES}; do
    if [ ! -f "${file}" ]; then
      touch "${file}"
    fi
  done
}

verify_logs

flag_limit_zero () {
  COUNT=0
  INVALID_FLAGS=
  for flag in ${@}; do
    COUNT=$((COUNT + 1))
    INVALID_FLAGS="${INVALID_FLAGS} ${flag} "
  done
  [ ${COUNT} -gt 0 ] && echo "Invalid flags:${INVALID_FLAGS}" && exit 1
}

flag_limit_one () {
  COUNT=0
  for flag in ${@}; do
    COUNT=$((COUNT + 1))
  done
  [ ${COUNT} -gt 1 ] && echo "Invalid flags:${INVALID_FLAGS}" && exit 1
}

[ "${LC_KILL}" = "y" ] && flag_limit_zero "${LC_BUMP}" "${LC_DELAY}"
[ "${LC_STATUS}" = "y" ] && flag_limit_zero "${LC_BUMP}" "${LC_DELAY}"
flag_limit_one "${LC_ALL}" "${LC_LOCAL}" "${LC_STATUS}" "${LC_KILL}"

[ "${LC_KILL}" != "y" ] && [ "${LC_STATUS}" != "y" ] && LC_RUNNING=$(screen -ls | grep livecheck | awk '{print $1}')

brew_livecheck () {
  [ "${LC_ALL}" = "y" ] && ${LC_SCREEN} "${SCRIPT_DIR}"/brew/livecheck/brew-livecheck-all.sh "${LC_BUMP}" "${LC_DELAY}"
  [ "${LC_LOCAL}" = "y" ] && ${LC_SCREEN} "${SCRIPT_DIR}"/brew/livecheck/brew-livecheck-local.sh "${LC_BUMP}" "${LC_DELAY}"
  [ "${LC_LOCAL_SCREEN}" = "y" ] && ${LC_SCREEN} "${SCRIPT_DIR}"/brew/livecheck/brew-livecheck-local-screen.sh "${LC_BUMP}" "${LC_DELAY}"
  [ "${LC_STATUS}" = "y" ] && "${SCRIPT_DIR}"/brew/livecheck/brew-livecheck-status.sh
  [ "${LC_KILL}" = "y" ] && "${SCRIPT_DIR}"/brew/livecheck/brew-livecheck-kill.sh
}

if [ -n "${LC_RUNNING}" ]; then
  echo "livecheck is already running"
  echo "kill livecheck: (y/n)"
  read -r LC_REPLACE
  if [ "${LC_REPLACE}" = "y" ] || [ "${LC_REPLACE}" = "yes" ]; then
    "${SCRIPT_DIR}"/brew/livecheck/brew-livecheck-kill.sh
    brew_livecheck
  fi
  if [ "${LC_REPLACE}" = "n" ] || [ "${LC_REPLACE}" = "no" ]; then
    exit 1
  fi
else
  brew_livecheck
fi

# it would be cool to be able to pass an argument that limits how many PRs are opened by run or in a day (continuous run)

# add flag to run reset on run
