#!/bin/bash

# ssh-keygen -t rsa
# iception

echo "Hi here!!"
cat /home/vagrant/.ssh/id_rsa.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cp -R  /home/vagrant/.ssh/*  /root/.ssh

sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*

sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

yum install -y net-tools

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --node-ip 192.168.42.110"
export K3S_KUBECONFIG_MODE="644"
curl -sfL https://get.k3s.io | sh -

#kubectl apply -f  /home/vagrant/test.yaml

# cp /var/lib/rancher/k3s/server/node-token /vagrant/token

# k3s kubectl get nodes -o wide
