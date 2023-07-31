#!/bin/sh

cd "${HOME}" || exit

echo "+ mac app upgrade"
# export APP_UPGRADE=$(mas upgrade 2>&1 | tail -r)
# if [ -z "${APP_UPGRADE##*Warning: Nothing found to upgrade*}" ]; then
#   echo "already up to date."
# else
#   echo ${APP_UPGRADE}
# fi
mas upgrade

echo "+ mac software upgrade"
# export SOFTWARE_UPGRADE=$(softwareupdate --all --install 2>&1 | tail -r)
# if [ -z "${SOFTWARE_UPGRADE##*No updates are available.*}" ]; then
#   echo "already up to date."
# else
#   echo ${SOFTWARE_UPGRADE}
# fi
softwareupdate --all --install
