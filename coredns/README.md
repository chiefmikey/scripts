# CodeDeploy

_Install configure and run [CoreDNS](https://github.com/coredns/coredns)_

## Amazon Linux 2

```sh
sudo yum install -y wget
sudo wget -O ~/coredns-al2.sh https://raw.githubusercontent.com/chiefmikey/scripts/main/coredns/coredns-al2.sh
sudo chmod +x ~/coredns-al2.sh
sudo ~/coredns-al2.sh
```

Resume screen with `screen -S coredns -r`

Detach screen with `ctrl + a` then `d`
