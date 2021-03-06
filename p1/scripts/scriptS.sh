#!/bin/bash

echo "Hi here!!"
cat /home/vagrant/.ssh/id_rsa.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cp -R  /home/vagrant/.ssh/*  /root/.ssh

yum install -y net-tools

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --node-ip 192.168.42.110"
export K3S_KUBECONFIG_MODE="644"
curl -sfL https://get.k3s.io | sh -
