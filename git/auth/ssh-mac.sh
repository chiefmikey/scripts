#!/bin/sh

# check for existing key?
ls -al ~/.ssh

# generate new key
ssh-keygen -t ed25519 -C "wolfemikl@gmail.com"
# enter file name or blank for default
# gh-ssh
# enter password or blank for none

# start ssh agent in background
eval "$(ssh-agent -s)"

# check if ssh config already exists
open ~/.ssh/config

# create ssh config
touch ~/.ssh/config

# add to config
echo '
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
' >> ~/.ssh/config

# add to keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# if no password
ssh-add ~/.ssh/id_ed25519

# add key manually to github

# add key with gh cli
gh ssh-key add ~/.ssh/id_ed25519.pub --title "id_ed25519"

# gh cli confirmation for ssh
ssh -T git@github.com