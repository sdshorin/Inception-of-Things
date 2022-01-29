#!/bin/bash

# ssh-keygen -t rsa
# iception

echo "Hi here!!"
cat /home/vagrant/.ssh/key.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cat  /home/vagrant/.ssh/key.pub >> /root/.ssh/authorized_keys

yum install -y net-tools

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --node-ip 192.168.42.110"
export K3S_KUBECONFIG_MODE="644"
curl -sfL https://get.k3s.io | sh -

# k3s kubectl get nodes -o wide
