#!/bin/bash

all_packages () {
  brew tap-info --json "$@" | jq -r '.[]|(.formula_names[],.cask_tokens[])' | sort -V
}

COUNTER_ONE=0
for rb in $(all_packages "${1}"); do
  echo "${rb##*/}"
  COUNTER_ONE=$((COUNTER_ONE+1))
done

# echo "homebrew/core: ${COUNTER_ONE}"

# COUNTER_TWO=0
# for rb in $(all_packages homebrew/cask); do
#   echo "${rb##*/}"
#   COUNTER_TWO=$((COUNTER_TWO+1))
# done

# echo "homebrew/cask: ${COUNTER_TWO}"

# COUNTER_FOUR=0
# for rb in $(all_packages homebrew/cask-versions); do
#   echo "${rb##*/}"
#   COUNTER_FOUR=$((COUNTER_FOUR+1))
# done

# echo "homebrew/cask-versions: ${COUNTER_FOUR}"

# echo "Totals:"
# echo "homebrew/core: ${COUNTER_ONE}"
# echo "homebrew/cask: ${COUNTER_TWO}"
# echo "homebrew/cask-versions: ${COUNTER_FOUR}"
