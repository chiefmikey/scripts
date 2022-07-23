#!/bin/sh

cd /home/ubuntu
apt update -y
apt upgrade -y
apt install -y git jq awscli
export user="chiefmikey"
export email="wolfemikl@gmail.com"
export repo="tales-from-the-script"
export owner="chiefmikey"
export awsRegion="us-east-2"
export awsSecretId="git-auth"
export pw=$(sudo aws secretsmanager --region ${awsRegion} get-secret-value --secret-id ${awsSecretId} | jq -r ".SecretString" | jq -r ".${awsSecretId}")
sleep 10
git init
git config user.name ${user}
git config user.email ${email}
git remote add origin https://${user}:${pw}@github.com/${owner}/${repo}.git
git fetch origin main
git checkout main
