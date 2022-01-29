#!/bin/bash

# ssh-keygen -t rsa
# iception

echo "Hi here!!"
cat /home/vagrant/.ssh/key.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cat  /home/vagrant/.ssh/key.pub >> /root/.ssh/authorized_keys

yum install -y net-tools

scp -o StrictHostKeyChecking=no root@192.168.42.110:/var/lib/rancher/k3s/server/node-token token

#curl -sfL https://get.k3s.io | sh -

