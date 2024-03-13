#!/bin/bash -v

set -x
cd /home/ec2-user
yum update -y && yum upgrade -y
yum install -y wget unzip git
rm -rf /usr/local/go
wget -O /home/ec2-user/go.tar.gz https://go.dev/dl/go1.18.3.linux-amd64.tar.gz
tar -C /usr/local -xzf /home/ec2-user/go.tar.gz
rm /home/ec2-user/go.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
source /etc/profile
git clone https://github.com/coredns/coredns
chown -R ec2-user:root /home/ec2-user/coredns
cd /home/ec2-user/coredns
su -s /bin/bash -c 'make' ec2-user
echo \
  ".:53 {
    rewrite name exact ${source} ${redirect}
    forward . 8.8.8.8:53
    bufsize 1232
    errors
    health {
      lameduck 20s
    }
  }" \
>> /home/ec2-user/coredns/Corefile
chmod +x /home/ec2-user/coredns/coredns
screen -S coredns -dm /home/ec2-user/coredns/coredns
