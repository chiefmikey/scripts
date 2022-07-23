#!/bin/sh

yum update -y
yum install -y git wget
mkdir -p /home/ec2-user/.docker/cli-plugins/
wget -O /home/ec2-user/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-x86_64
chmod +x /home/ec2-user/.docker/cli-plugins/docker-compose
ln -s /home/ec2-user/.docker/cli-plugins/docker-compose /usr/bin/docker-compose
amazon-linux-extras install docker
usermod -a -G docker ec2-user
systemctl enable --now docker
chkconfig docker on
chmod 666 /var/run/docker.sock
docker compose -f /home/ec2-user/docker-compose.yaml pull
docker compose -f /home/ec2-user/docker-compose.yaml up -d
