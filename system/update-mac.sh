#!/bin/sh

echo "+ app update" && mas upgrade
echo "+ software update" && softwareupdate --all --install
