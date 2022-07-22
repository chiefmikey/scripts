#!/bin/zsh

brew autoupdate delete
echo "+ brew update" && brew update
echo "+ brew upgrade" && brew upgrade --greedy
echo "+ brew cleanup" && brew cleanup
brew autoupdate start 21600 --upgrade --cleanup --greedy --immediate
