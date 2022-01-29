#!/bin/bash

# ssh-keygen -t rsa
# iception

echo "Hi here!!"
cat /home/vagrant/.ssh/id_rsa.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cp -R  /home/vagrant/.ssh/*  /root/.ssh


yum install -y net-tools

scp -o StrictHostKeyChecking=no root@192.168.42.110:/var/lib/rancher/k3s/server/node-token /home/vagrant/token
# cat /vagrant/token
# cp /vagrant/token ~/token
#curl -sfL https://get.k3s.io | sh -

