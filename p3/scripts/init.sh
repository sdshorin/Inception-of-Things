#!/bin/bash

sudo cat /home/vagrant/.ssh/id_rsa.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
sudo cp -R  /home/vagrant/.ssh/*  /root/.ssh

sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh
sudo usermod -aG docker $USER

curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
