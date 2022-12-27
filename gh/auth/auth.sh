#!/bin/sh

awsRegion="us-east-2"
awsSecretId="gh-sudo"
pat="$(aws secretsmanager --region ${awsRegion} get-secret-value --secret-id ${awsSecretId} | jq -r ".SecretString" | jq -r ".[\"$awsSecretId\"]")"

touch pat.txt
echo "${pat}" > pat.txt

gh auth login -p ssh --with-token < pat.txt

rm pat.txt