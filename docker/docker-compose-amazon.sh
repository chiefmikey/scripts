sudo yum update -y
sudo yum install -y git wget
mkdir -p /home/ec2-user/.docker/cli-plugins/
wget -O /home/ec2-user/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-x86_64
sudo chmod +x /home/ec2-user/.docker/cli-plugins/docker-compose
sudo ln -s /home/ec2-user/.docker/cli-plugins/docker-compose /usr/bin/docker-compose
sudo amazon-linux-extras install docker
sudo usermod -a -G docker $USER
sudo su $USER
sudo systemctl enable --now docker
sudo chkconfig docker on
sudo chmod 666 /var/run/docker.sock
docker compose -f /home/ec2-user/docker-compose.yaml pull
docker compose -f /home/ec2-user/docker-compose.yaml up -d
