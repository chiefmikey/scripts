#!/bin/sh

export SUDO_ASKPASS=$(${SCRIPT_DIR}/homebrew/ask-pass.sh)
brew autoupdate stop
echo "+ brew update" && brew update
echo "+ brew upgrade" && brew upgrade --greedy
echo "+ brew cleanup" && brew cleanup
${SCRIPT_DIR}/homebrew/update-homebrew-auto.sh ${1}
