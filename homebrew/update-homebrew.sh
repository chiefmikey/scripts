#!/bin/sh

export SUDO_ASKPASS=$(${SCRIPT_DIR}/homebrew/ask-pass.sh)
brew autoupdate delete
echo "+ brew update" && brew update
echo "+ brew upgrade" && brew upgrade --greedy
echo "+ brew cleanup" && brew cleanup
brew autoupdate start 43200 --upgrade --cleanup --greedy --immediate
