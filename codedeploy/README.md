# CodeDeploy

_Install and run CodeDeploy agent_

## Ubuntu

```sh
#!/bin/bash
apt install -y wget
wget https://raw.githubusercontent.com/chiefmikey/scripts/main/codedeploy/codedeploy-ubuntu.sh
chmod +x ./codedeploy-ubuntu.sh
./codedeploy-ubuntu.sh
```

## Amazon Linux 2

```sh
#!/bin/bash
yum install -y wget
wget https://raw.githubusercontent.com/chiefmikey/scripts/main/codedeploy/codedeploy-linux.sh
chmod +x ./codedeploy-linux.sh
./codedeploy-linux.sh
```
