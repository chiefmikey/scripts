#!/bin/sh

echo "+ brew livecheck all"
cd "${HOME}" || exit

FLAG_LIST="bt"
while getopts 'bt:' OPTION; do
  case $OPTION in
    b)
      LC_BUMP="y"
      ;;
    t)
      LC_DELAY=${OPTARG}
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

verify_logs () {
  LOG_DIR="${SCRIPT_DIR}/brew/livecheck/log"
  LOG_LOG="${LOG_DIR}/brew-livecheck-log.log"
  LOG_ERROR="${LOG_DIR}/brew-livecheck-error.log"
  LOG_HEALTH="${LOG_DIR}/brew-livecheck-health.log"
  LOG_HISTORY="${LOG_DIR}/brew-livecheck-history.log"
  LOG_UPGRADE="${LOG_DIR}/brew-livecheck-upgrade.log"
  LOG_FILES="${LOG_LOG} ${LOG_ERROR} ${LOG_HEALTH} ${LOG_HISTORY} ${LOG_UPGRADE}"

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
:> "${SCRIPT_DIR}"/brew/livecheck/log/brew-livecheck-history.log

health_check () {
  "${SCRIPT_DIR}"/input/health-check/input-health-check.sh
}

killer () {
  COUNT=0
  while [ "${COUNT}" -lt 5 ]; do
    if [ "${COUNT}" -gt 0 ]; then
      REMAINING=$((5 - COUNT))
      echo "${1} is taking a long time."
      echo "Waiting ${REMAINING} more minutes..."
    fi
    COUNT=$(COUNT + 1)
    SCREEN=$(screen -ls)
    if [ -z "${SCREEN##*No Sockets found in*}" ]; then
      COUNT=5
    fi
    sleep 60
  done
  if [ "${COUNT}" -eq 5 ]; then
    echo "Killing screen"
    screen -S "${1}" -X quit
  fi
}

bump_formula () {
  BUMP_VERSIONS=
  LC_FORMULA=$(brew lc --newer-only --formula "${1}" 2>&1)
  echo "${LC_FORMULA}"
  if [ -z "${LC_FORMULA##*==>*}" ]; then
    FORMULA_V=${LC_FORMULA#* }
    OLD_FORMULA_V=${FORMULA_V%% *}
    NEW_FORMULA_V=${FORMULA_V#*> }
    if [ "${LC_BUMP}" = "y" ]; then
      brew bump-formula-pr --no-browse --version "${NEW_FORMULA_V}" "${1}"
      brew cleanup -s
      BUMP_VERSIONS=" | ${OLD_FORMULA_V} => ${NEW_FORMULA_V}"
    else
      echo "${OLD_FORMULA_V} => ${NEW_FORMULA_V}"
    fi
  fi
}

bump_cask () {
  BUMP_VERSIONS=
  LC_CASK=$(brew lc --newer-only --cask "${1}" 2>&1)
  echo "${LC_CASK}"
  if [ -z "${LC_CASK##*==>*}" ]; then
    CASK_V=${LC_CASK#* }
    OLD_CASK_V=${CASK_V%% *}
    NEW_CASK_V=${CASK_V#*> }
    if [ "${LC_BUMP}" = "y" ]; then
      brew bump-cask-pr --no-browse --version "${NEW_CASK_V}" "${1}"
      brew cleanup -s
      BUMP_VERSIONS=" | ${OLD_CASK_V} => ${NEW_CASK_V}"
    else
      echo "${OLD_CASK_V} => ${NEW_CASK_V}"
    fi
  fi
}

package_counter () {
  COUNTER=0
  for cask in $("${SCRIPT_DIR}"/brew/search/brew-search.sh "${1}"); do
    COUNTER=$((${COUNTER} + 1))
  done
  echo "${COUNTER}"
}

LOG=${SCRIPT_DIR}/brew/livecheck/log/brew-livecheck-log.log
UPGRADE_LOG=${SCRIPT_DIR}/brew/livecheck/log/brew-livecheck-upgrade.log
HISTORY_LOG=${SCRIPT_DIR}/brew/livecheck/log/brew-livecheck-history.log
CURRENT_LOG=$(cat "${LOG}")
CURRENT_TAP=${CURRENT_LOG%:*}
CURRENT_COUNT=${CURRENT_LOG#*:}
CASK_FONTS=homebrew/cask-fonts
LINUXBREW_FONTS=linuxbrew/fonts
CASK_DRIVERS=homebrew/cask-drivers
CASK_VERSIONS=homebrew/cask-versions
BREW_CASK=homebrew/cask
BREW_CORE=homebrew/core
COUNTER=0
TOTAL_COUNT=0
TYPE=
TAP=
PACKAGE=

update_currents () {
  CURRENT_LOG=$(cat "${LOG}")
  CURRENT_TAP=${CURRENT_LOG%:*}
  CURRENT_COUNT=${CURRENT_LOG#*:}
}

write_date () {
  echo $(TZ=:US/Mountain date +%m-%d-%y:%H-%M-%S)
}

write_log () {
  echo "${SHELL} | $(write_date) | ${TAP}: ${COUNTER}/${TOTAL_COUNT} | ${TYPE}: ${PACKAGE}${BUMP_VERSIONS}"
}

clear_log () {
  :> "${LOG}"
}

bump_runner () {
  update_currents
  TYPE=${1}
  TAP=${2}
  COUNTER=0
  TOTAL_COUNT=$(package_counter "${TAP}")
  echo "${2}: ${TOTAL_COUNT} ${TYPE}s"

  for package in $("${SCRIPT_DIR}"/brew/search/brew-search.sh "${TAP}"); do
    PACKAGE=${package}
    COUNTER=$((${COUNTER} + 1))

    if [[ ${COUNTER} -gt $((${CURRENT_COUNT} - 3)) ]] && [[ ! ${COUNTER} -gt ${CURRENT_COUNT} ]]; then
      echo "...${TAP}: ${COUNTER}/${TOTAL_COUNT}"
      echo "...${TYPE}: ${package}"
    fi

    if [ -z "${CURRENT_COUNT}" ] || [ ${COUNTER} -gt "${CURRENT_COUNT}" ]; then
      HEALTH_CHECK=$(health_check)

      while [ "${HEALTH_CHECK}" = "disconnected" ]; do
        echo "disconnected..."
        echo "disconnected: $(write_date)" >> "${SCRIPT_DIR}"/brew/livecheck/log/brew-livecheck-health.log
        sleep 60
        HEALTH_CHECK=$(health_check)
      done

      echo "+ $(write_date)"
      echo "${TAP}: ${COUNTER}/${TOTAL_COUNT}"
      echo "${TYPE}: ${PACKAGE}"

      [ "${TYPE}" = "formula" ] && bump_formula "${PACKAGE}"
      [ "${TYPE}" = "cask" ] && bump_cask "${PACKAGE}"

      echo "${TAP}:${COUNTER}" > "${LOG}"
      write_log >> "${HISTORY_LOG}"
      [ -n "${BUMP_VERSIONS}" ] && write_log >> "${UPGRADE_LOG}"
      [ ${COUNTER} -eq "${TOTAL_COUNT}" ] && clear_log
      if [ -n "${LC_DELAY}" ]; then
        sleep "${LC_DELAY}"
      fi
    fi
  done
}

LC_RUNNING=true
LC_DONE=false
while [ "${LC_RUNNING}" = "true" ] && [ "${LC_DONE}" = "false" ]; do
  if [ -n "${CURRENT_LOG}" ]; then
    [ "${CURRENT_TAP}" = "${CASK_FONTS}" ] && bump_runner cask ${CASK_FONTS} "${CURRENT_COUNT}" && CURRENT_TAP=${LINUXBREW_FONTS}
    [ "${CURRENT_TAP}" = "${LINUXBREW_FONTS}" ] && bump_runner formula ${LINUXBREW_FONTS} "${CURRENT_COUNT}" && CURRENT_TAP=${CASK_DRIVERS}
    [ "${CURRENT_TAP}" = "${CASK_DRIVERS}" ] && bump_runner cask ${CASK_DRIVERS} "${CURRENT_COUNT}" && CURRENT_TAP=${CASK_VERSIONS}
    [ "${CURRENT_TAP}" = "${CASK_VERSIONS}" ] && bump_runner cask ${CASK_VERSIONS} "${CURRENT_COUNT}" && CURRENT_TAP=${BREW_CASK}
    [ "${CURRENT_TAP}" = "${BREW_CASK}" ] && bump_runner cask ${BREW_CASK} "${CURRENT_COUNT}" && CURRENT_TAP=${BREW_CORE}
    [ "${CURRENT_TAP}" = "${BREW_CORE}" ] && bump_runner formula ${BREW_CORE} "${CURRENT_COUNT}" && CURRENT_TAP=${CASK_FONTS}
  else
    bump_runner cask ${CASK_FONTS} "${CURRENT_COUNT}" && CURRENT_TAP=${LINUXBREW_FONTS}
  fi
done
