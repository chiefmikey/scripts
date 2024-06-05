#!/bin/bash

# find and install correct driver ex. https://github.com/lwfinger/rtl8852au

# get directory name that starts with "w"
ls /sys/class/net

# update netplan config
ls /etc/netplan
sudo nano /etc/netplan/01-netconf.yaml
# copy contents from local 01-netconf.yaml

# and apply netplan
sudo netplan apply

# disable network boot check (two minute delay)
sudo systemctl disable systemd-networkd-wait-online.service
