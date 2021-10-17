#!/bin/sh

INSTANCE_ALREADY_STARTED="INSTANCE_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e ~/$INSTANCE_ALREADY_STARTED ]; then
sudo touch ~/$INSTANCE_ALREADY_STARTED
  echo "-- First instance startup --"
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y wget unzip
    wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.17.34.02.zip
    unzip bedrock-server-1.17.34.02.zip
    rm bedrock-server-1.17.34.02.zip
    sudo wget -O ~/server.properties https://raw.githubusercontent.com/chiefmikey/scripts/main/mc-server/server.properties
    sudo wget -O ~/whitelist.json https://github.com/chiefmikey/scripts/blob/main/mc-server/whitelist.json
    sudo wget -O https://github.com/chiefmikey/scripts/blob/main/mc-server/permissions.json
    LD_LIBRARY_PATH=. ./bedrock_server
else
  echo "-- Not first instance startup --"
    sudo wget -O https://raw.githubusercontent.com/chiefmikey/scripts/main/mc-server/server.properties
    sudo wget -O https://github.com/chiefmikey/scripts/blob/main/mc-server/whitelist.json
    sudo wget -O https://github.com/chiefmikey/scripts/blob/main/mc-server/permissions.json
    LD_LIBRARY_PATH=. ./bedrock_server
fi
