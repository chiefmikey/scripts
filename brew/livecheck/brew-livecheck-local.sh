#!/bin/sh

echo "+ brew livecheck local"
cd "${HOME}" || exit

while getopts 'bt:' OPTION; do
  case $OPTION in
    b)
      LC_BUMP="y"
      ;;
    t)
      LC_DELAY=${OPTARG}
      ;;
  esac
done
shift "$((OPTIND-1))"

livecheck_cask () {
  echo "Casks:"
  for cask in $(brew list --cask -1); do
    echo "${cask}:"
    LC_CASK=$(brew lc --newer-only --cask "${cask}" 2>&1)
    echo "${LC_CASK}"
    if [ -z "${LC_CASK##*==>*}" ] && [ "${LC_BUMP}" = "y" ]; then
      CASK_V=${LC_CASK#* }
      OLD_CASK_V=${CASK_V%% *}
      NEW_CASK_V=${CASK_V#*> }
      if [ "${OLD_CASK_V}" != "${NEW_CASK_V}" ]; then
        brew bump-cask-pr --no-browse --version "${NEW_CASK_V}" "${cask}"
      fi
    fi
    if [ -n "${LC_DELAY}" ]; then
      sleep "${LC_DELAY}"
    fi
  done
}

livecheck_formula () {
  echo "Formulas:"
  for formula in $(brew list --formula -1); do
    echo "${formula}:"
    LC_FORMULA=$(brew lc --newer-only --formula "${formula}" 2>&1)
    echo "${LC_FORMULA}"
    if [ -z "${LC_FORMULA##*==>*}" ] && [ "${LC_BUMP}" = "y" ]; then
      FORMULA_V=${LC_FORMULA#* }
      OLD_FORMULA_V=${FORMULA_V%% *}
      NEW_FORMULA_V=${FORMULA_V#*> }
      if [ "${OLD_FORMULA_V}" != "${NEW_FORMULA_V}" ]; then
        brew bump-formula-pr --no-browse --version "${NEW_FORMULA_V}" "${formula}"
      fi
    fi
    if [ -n "${LC_DELAY}" ]; then
      sleep "${LC_DELAY}"
    fi
  done
}

livecheck_cask && livecheck_formula
