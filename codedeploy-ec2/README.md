# CodeDeploy EC2

_Install and run CodeDeploy agent on an AWS EC2 instance_

## Ubuntu

```sh
#!/bin/bash
apt install -y wget
wget https://raw.githubusercontent.com/chiefmikey/scripts/main/codedeploy-ec2/codedeploy-ec2-ubuntu.sh
chmod +x ./codedeploy-ec2-ubuntu.sh
./codedeploy-ec2-ubuntu.sh
```

## Linux

```sh
#!/bin/bash
yum install -y wget
wget https://raw.githubusercontent.com/chiefmikey/scripts/main/codedeploy-ec2/codedeploy-ec2-linux.sh
chmod +x ./codedeploy-ec2-linux.sh
./codedeploy-ec2-linux.sh
```
