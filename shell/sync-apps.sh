#!/bin/zsh

while getopts 'y' OPTION; do
  case $OPTION in
    y)
      export Y1="y"
      export Y2="y"
      ;;
  esac
done
shift "$((OPTIND-1))"

export DEFAULT_ROOT="~/dropbox/dev/apps"
export DEFAULT_PULL_METHOD="rebase"
export ROOT=${1}
export ROOT=${ROOT/"~"/${HOME}}
export DEFAULT_ROOT=${DEFAULT_ROOT/"~"/${HOME}}
export PULL_METHOD=${2}

while
  [ -z ${ROOT} ] ||
  [ ! -d ${ROOT} ]; do
    if [ -z ${Y1} ]; then
      export Y1="unset"
    fi
    if [ -z ${ROOT} ]; then
      while
        [ ${Y1} != "y" ] &&
        [ ${Y1} != "yes" ] &&
        [ ${Y1} != "n" ] &&
        [ ${Y1} != "no" ]; do
          echo "+ Use Default Root (${DEFAULT_ROOT})? [y/n]:"
          read Y1
          if [ -z ${Y1} ]; then
            export Y1="unset"
          fi
      done
      if [ ${Y1} = "y" ] || [ ${Y1} = "yes" ]; then
        export ROOT=${DEFAULT_ROOT}
      elif [ ${Y1} = "n" ] || [ ${Y1} = "no" ]; then
        echo "+ Input Root:"
        read ROOT
        if [ -z ${ROOT} ]; then
          export ROOT="unset"
        else
          export ROOT=${ROOT/"~"/${HOME}}
        fi
      fi
    fi
    if [ ! -d ${ROOT} ]; then
      if [ ${ROOT} != "unset" ]; then
        echo "Invalid Root"
      fi
      echo "+ Input Root:"
      read ROOT
      if [ -z ${ROOT} ]; then
        export ROOT="unset"
      else
        export ROOT=${ROOT/"~"/${HOME}}
      fi
    fi
done

while [ -z ${PULL_METHOD} ]; do
  if [ -z ${Y2} ]; then
    export Y2="unset"
  fi
  while
    [ ${Y2} != "y" ] &&
    [ ${Y2} != "yes" ] &&
    [ ${Y2} != "n" ] &&
    [ ${Y2} != "no" ]; do
      echo "+ Use Default Pull Method (${DEFAULT_PULL_METHOD})? [y/n]:"
      read Y2
      if [ -z ${Y2} ]; then
        export Y2="unset"
      fi
  done
  if [ ${Y2} = "y" ] || [ ${Y2} = "yes" ]; then
    export PULL_METHOD=${DEFAULT_PULL_METHOD}
  elif [ ${Y2} = "n" ] || [ ${Y2} = "no" ]; then
    echo "+ Input Pull Method [rebase/merge]:"
    read PULL_METHOD
    if [ -z ${PULL_METHOD} ]; then
      export PULL_METHOD="unset"
    fi
  fi
done

while
  [ ${PULL_METHOD} != "rebase" ] &&
  [ ${PULL_METHOD} != "merge" ]; do
    if [ ${PULL_METHOD} != "unset" ]; then
      echo "Invalid Pull Method"
    fi
    echo "+ Input Pull Method [rebase/merge]:"
    read PULL_METHOD
    if [ -z ${PULL_METHOD} ]; then
      export PULL_METHOD="unset"
    fi
done

echo "Root: ${ROOT}"
echo "Pull Method: ${PULL_METHOD}"

if [ ${PULL_METHOD} = "rebase" ]; then
  find ${ROOT} -type d -name ".git" -exec ${ROOT}/extra/scripts/rebase-all.sh {} \;
elif [ ${PULL_METHOD} = "merge" ]; then
  find ${ROOT} -type d -name ".git" -exec ${ROOT}/extra/scripts/merge-all.sh {} \;
fi
