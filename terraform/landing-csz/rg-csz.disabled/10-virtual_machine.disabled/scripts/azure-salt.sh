#!/bin/bash
apt-get update
apt-get install -y jq
HOST=$(curl -s  -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-06-01" |jq '.compute.tagsList' | grep '"name": "name"' -C1 | grep value |awk -F: '{ print $2}' | sed 's/"//g')
sudo echo $HOST > /etc/hostname
sudo hostnamectl set-hostname $HOST --static
sudo hostnamectl set-hostname $HOST --pretty
sudo hostnamectl set-hostname $HOST --transient
curl -sL https://bootstrap.saltproject.io | sudo sh -s -- -A 10.158.241.118  -x python3 stable 3003.1 
sudo systemctl restart salt-minion 
sudo systemctl enable salt-minion
echo $HOST > /tmp/deploy
echo "lalala" > /root/deploy.txt
