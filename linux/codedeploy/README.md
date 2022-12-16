# CodeDeploy

_Install and run [CodeDeploy](https://aws.amazon.com/codedeploy/) agent_

```sh
# Ubuntu
apt install -y wget
wget -O ~/codedeploy-ubuntu.sh https://raw.githubusercontent.com/chiefmikey/tales-from-the-script/main/codedeploy/codedeploy-ubuntu.sh
sudo chmod +x ~/codedeploy-ubuntu.sh
sudo ~/codedeploy-ubuntu.sh
```

```sh
# Amazon Linux 2
yum install -y wget
wget -O ~/codedeploy-al2.sh https://raw.githubusercontent.com/chiefmikey/linux-codedeploy/main/linux-codedeploy-al2.sh
sudo chmod +x ~/codedeploy-al2.sh
sudo ~/codedeploy-al2.sh
```
