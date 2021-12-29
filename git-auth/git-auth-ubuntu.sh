#!/bin/bash

cd /home/ubuntu
apt update -y
apt upgrade -y
apt install -y wget zip unzip git jq awscli curl
pw=$(aws secretsmanager --region us-east-2 get-secret-value --secret-id git-auth | jq -r ".SecretString" | jq -r ".git-auth")
sleep 10
git init
git config user.name chiefmikey
git config user.email wolfemikl@gmail.com
git remote add origin https://chiefmikey:${pw}@github.com/chiefmikey/tales-from-the-script.git
git fetch origin main
git checkout main
