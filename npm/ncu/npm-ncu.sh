#!/bin/sh -v

set -x
brew update && brew upgrade && brew cleanup
export PATH1=package.json
export PATH2=package-lock.json
export MESSAGE='Update dependencies'
cd ~/dropbox/dev/apps/auth-server && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/chalet-le-jar && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/chiefmikey && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/cloudy-nights && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/docker-images && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/eslint-plugin-disable-autofix && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/extra && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/gitlang && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/name-generator && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/secret-souls && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/stats && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/tales-from-the-script && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/template-cemetery && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/the-myspace && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/tomorrow-night-darkly && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/view-master-3000 && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/you-got-this && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
cd ~/dropbox/dev/apps/zourdough && git pull --no-edit && ncu -u && npm i && git commit ${PATH1} ${PATH2} -m ${MESSAGE} && git push
