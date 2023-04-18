#!/bin/sh

echo "+ brew livecheck local"
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

livecheck_cask () {
  for cask in $(brew list --cask -1); do
    LC_CASK=$(brew lc --newer-only --cask "${cask}" 2>&1) && cask_messenger && echo "${CASK_MESSAGE}" && bump_cask
    if [ -n "${LC_DELAY}" ]; then
      sleep "${LC_DELAY}"
    fi
  done
}

bump_cask () {
  if [ -z "${LC_CASK##*==>*}" ] && [ "${LC_BUMP}" = "y" ]; then
    CASK_V=${LC_CASK#* }
    OLD_CASK_V=${CASK_V%% *}
    NEW_CASK_V=${CASK_V#*> }
    if [ "${OLD_CASK_V}" != "${NEW_CASK_V}" ]; then
      brew bump-cask-pr --no-browse --version "${NEW_CASK_V}" "${cask}"
    fi
  fi
}

cask_messenger () {
  if [ -z "${LC_CASK##*No newer*}" ]; then
    CASK_MESSAGE="${cask}"
  elif [ -z "${LC_CASK##*==>*}" ]; then
    CASK_MESSAGE="${LC_CASK}"
  fi
}

livecheck_formula () {
  for formula in $(brew list --formula -1); do
    LC_FORMULA=$(brew lc --newer-only --formula "${formula}" 2>&1) && formula_messenger && echo "${FORMULA_MESSAGE}" && bump_formula
    if [ -n "${LC_DELAY}" ]; then
      sleep "${LC_DELAY}"
    fi
  done
}

bump_formula () {
  if [ -z "${LC_FORMULA##*==>*}" ] && [ "${LC_BUMP}" = "y" ]; then
    FORMULA_V=${LC_FORMULA#* }
    OLD_FORMULA_V=${FORMULA_V%% *}
    NEW_FORMULA_V=${FORMULA_V#*> }
    if [ "${OLD_FORMULA_V}" != "${NEW_FORMULA_V}" ]; then
      brew bump-formula-pr --no-browse --version "${NEW_FORMULA_V}" "${formula}"
    fi
  fi
}

formula_messenger () {
  if [ -z "${LC_FORMULA##*No newer*}" ]; then
    FORMULA_MESSAGE="${formula}"
  elif [ -z "${LC_FORMULA##*==>*}" ]; then
    FORMULA_MESSAGE="${LC_FORMULA}"
  fi
}

livecheck_cask && livecheck_formula

# cool to be able to simplify the results to cask: status (updated 1 => 2, duplicate, up-to-date)
# have a debug flag that will output the raw message
