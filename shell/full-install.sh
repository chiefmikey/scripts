#!/bin/zsh -v

set -x
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&
# Install packages
brew install \
  curl \
  wget \
  gnupg \
  pinentry-mac \
  git \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  postgresql \
  node \
  yarn \
  mosh \
  xxh \
  git-lfs \
  openconnect \
  docker \
  pnpm &&
# Enable alternate cask versions
brew tap homebrew/cask-versions &&
# Enable auto update
brew tap homebrew/autoupdate &&
brew autoupdate start 21600 --upgrade --cleanup --greedy --immediate &&
# Install Homebrew casks
brew install --cask \
# Install general programs
  google-chrome-canary \
  google-chrome \
  dropbox \
  notion \
  lastpass \
  istat-menus \
  shift \
  rectangle \
  vlc \
  figma \
  parallels \
  vnc-viewer \
  vnc-server \
  microsoft-teams \
  microsoft-outlook \
  slack \
  flux \
  keka \
  kekaexternalhelper \
# Install dev programs
  docker \
  visual-studio-code-insiders \
  visual-studio-code \
  iterm2 \
  postman \
  gpg-suite \
  raspberry-pi-imager \
# Install audio programs
  sonic-pi \
  spotify \
  waves-central \
  izotope-product-portal  \
  xld \
# Install visual programs
  affinity-designer \
  handbrake \
  obs \
  affinity-photo &&
# Configure git
git config user.name chiefmikey &&
git config user.email wolfemikl@gmail.com &&
git config --global pull.rebase merges &&
git config --global rebase.autoStash true &&
git lfs install &&
# Install dropbox ignore
sudo sh -c "$(wget -qO- https://raw.githubusercontent.com/sp1thas/dropboxignore/master/utils/install.sh)" &&
# Configure gnupg
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf &&
killall gpg-agent &&
# Configure npm
npm config set fund false &&
# Install ncu
npm install -g npm-check-updates
