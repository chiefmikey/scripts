#!/bin/sh

while getopts 'y' OPTION; do
  case $OPTION in
    y)
      export Y1="y"
      export Y2="y"
      ;;
  esac
done
shift "$((OPTIND-1))"

export DEFAULT_PULL_METHOD="rebase"
export DEFAULT_ROOT="~/dropbox/dev/apps"
export DEFAULT_ROOT=${DEFAULT_ROOT/"~"/${HOME}}
export ROOT=${1}
export ROOT=${ROOT/"~"/${HOME}}
export PULL_METHOD=${2}
export ADD_PATH=${3}
export COMMIT_MESSAGE=${4}

${HOME}/dropbox/dev/apps/extra/scripts/input-path.sh -d ${DEFAULT_ROOT} -n "Root" ${ROOT}
${HOME}/dropbox/dev/apps/extra/scripts/input-pull-method.sh -d ${DEFAULT_PULL_METHOD} ${PULL_METHOD}

echo "Root: ${ROOT}"
echo "Pull Method: ${PULL_METHOD}"
echo "Add Path: ${ADD_PATH}"
echo "Commit Message: ${COMMIT_MESSAGE}"

export PATH=.github
export MESSAGE='Update dependabot workflow'
cd ~/dropbox/dev/apps/auth-server && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/chalet-le-jar && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/chiefmikey && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/cloudy-nights && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/docker-images && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/eslint-plugin-disable-autofix && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/extra && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/gitlang && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/name-generator && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/secret-souls && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/stats && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/tales-from-the-script && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/template-cemetery && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/the-myspace && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/tomorrow-night-darkly && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/view-master-3000 && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/you-got-this && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/zourdough && git pull --rebase=false --autostash --no-edit && git add ${PATH} && git commit ${PATH} -m ${MESSAGE} && git push
