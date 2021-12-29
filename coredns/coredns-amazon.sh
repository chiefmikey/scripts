#!/bin/bash

cd /home/ec2-user
yum update -y
yum install -y wget unzip git
rm -rf /usr/local/go
wget -O /home/ec2-user/go.tar.gz https://golang.org/dl/go1.17.3.linux-amd64.tar.gz
tar -C /usr/local -xzf /home/ec2-user/go.tar.gz
rm /home/ec2-user/go.tar.gz
mkdir /home/ec2-user/go
chown -R ec2-user:root /home/ec2-user/go
echo "export GOPATH=/home/ec2-user/go" >> /home/ec2-user/.bashrc
echo "export PATH=$PATH:$GOPATH/bin" >> /home/ec2-user/.bashrc
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
source /etc/profile
git clone https://github.com/coredns/coredns
chown -R ec2-user:root /home/ec2-user/coredns
cd /home/ec2-user/coredns
su -s /bin/bash -c 'make' ec2-user
echo \
  ".:53 {
    rewrite name exact source.address.com redirect.address.com
    forward . 8.8.8.8:53
    bufsize 1232
    errors
    health {
      lameduck 20s
    }
  }" \
>> /home/ec2-user/coredns/Corefile
chmod +x /home/ec2-user/coredns/coredns
su -s /bin/bash -c 'screen -S coredns -dm /home/ec2-user/coredns/coredns' root
