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
    LD_LIBRARY_PATH=. ./bedrock_server
else
  echo "-- Not first instance startup --"
    LD_LIBRARY_PATH=. ./bedrock_server
fi
