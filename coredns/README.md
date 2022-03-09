# CodeDeploy

_Install configure and run [CoreDNS](https://github.com/coredns/coredns)_

```sh
# Amazon Linux 2
yum install -y wget
wget -O ~/coredns-amazon.sh https://raw.githubusercontent.com/chiefmikey/scripts/main/coredns/coredns-amazon.sh
export source=source.address.com # Redirect source
export redirect=redirect.address.com # Redirect destination
sudo chmod +x ~/coredns-amazon.sh
sudo ~/coredns-amazon.sh
```

Resume screen with `screen -r coredns`

Detach screen with `ctrl + a` then `d`
