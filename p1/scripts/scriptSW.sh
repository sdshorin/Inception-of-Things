#!/bin/bash

# ssh-keygen -t rsa
# iception

echo "Hi here!!"
cat /home/vagrant/.ssh/id_rsa.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cp -R  /home/vagrant/.ssh/*  /root/.ssh


yum install -y net-tools
echo "start loading token"
scp -o StrictHostKeyChecking=no root@192.168.42.110:/var/lib/rancher/k3s/server/node-token /home/vagrant/token
# echo "token:"
# cat /home/vagrant/token
# echo "token:end"
# ssh root@192.168.42.110
# echo "--------"
# cat /vagrant/token
# cp /vagrant/token ~/token
#curl -sfL https://get.k3s.io | sh -

export INSTALL_K3S_EXEC="agent --server https://192.168.42.110:6443 --node-ip 192.168.42.111 --token-file /home/vagrant/token"
# export K3S_KUBECONFIG_MODE="644"
curl -sfL https://get.k3s.io | sh -

