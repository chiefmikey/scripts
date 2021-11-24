# CodeDeploy

_Install and run [CodeDeploy](https://aws.amazon.com/codedeploy/) agent_

## Ubuntu

```sh
#!/bin/bash
sudo apt install -y wget
sudo wget -O ~/codedeploy-ubuntu.sh https://raw.githubusercontent.com/chiefmikey/scripts/main/codedeploy/codedeploy-ubuntu.sh
sudo chmod +x ~/codedeploy-ubuntu.sh
sudo ~/codedeploy-ubuntu.sh
```

## Amazon Linux 2

```sh
#!/bin/bash
sudo yum install -y wget
sudo wget -O ~/codedeploy-al2.sh https://raw.githubusercontent.com/chiefmikey/scripts/main/codedeploy/codedeploy-al2.sh
sudo chmod +x ~/codedeploy-al2.sh
sudo ~/codedeploy-al2.sh
```
