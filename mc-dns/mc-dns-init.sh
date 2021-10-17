#!/bin/sh

INSTANCE_ALREADY_STARTED="INSTANCE_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e ~/$INSTANCE_ALREADY_STARTED ]; then
sudo touch ~/$INSTANCE_ALREADY_STARTED
  echo "-- First instance startup --"
    sudo yum update -y
    sudo yum install -y wget unzip git
    sudo rm -rf /usr/local/go
    wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz
    rm go1.17.2.linux-amd64.tar.gz
    sudo echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
    source ~/.profile
    git clone https://github.com/coredns/coredns
    cd coredns
    make
    sudo echo \
      ".:53 {
        rewrite name exact mco.lbsg.net chaletlejar.com
        forward . 1.1.1.1:53
      }" \
    >> ~/coredns/Corefile
    sudo chmod +x ~/coredns/coredns
    sudo ~/coredns/coredns
else
  echo "-- Not first instance startup --"
    sudo yum update -y
    sudo ~/coredns/coredns
fi
