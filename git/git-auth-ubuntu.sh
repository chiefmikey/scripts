#!/bin/bash

cd /home/ubuntu
apt update -y
apt upgrade -y
apt install -y git jq awscli
pw=$(aws secretsmanager --region us-east-2 get-secret-value --secret-id git-auth | jq -r ".SecretString" | jq -r ".git-auth")
sleep 10
git init
git config user.name ${user}
git config user.email wolfemikl@gmail.com
git remote add origin https://${user}:${pw}@github.com/${user}/${repo}.git
git fetch origin main
git checkout main
