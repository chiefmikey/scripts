# CodeDeploy

_Install configure and run [CoreDNS](https://github.com/coredns/coredns)_

```sh
# Amazon Linux 2
sudo yum install -y wget
sudo wget -O ~/coredns-amazon.sh https://raw.githubusercontent.com/chiefmikey/scripts/main/coredns/coredns-amazon.sh
sudo chmod +x ~/coredns-amazon.sh
sudo ~/coredns-amazon.sh
```

Resume screen with `screen -S coredns -r`

Detach screen with `ctrl + a` then `d`
