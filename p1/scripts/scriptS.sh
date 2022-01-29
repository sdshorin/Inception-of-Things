#!/bin/bash

# ssh-keygen -t rsa
# iception

echo "Hi here!!"
cat /home/vagrant/.ssh/key.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cat  /home/vagrant/.ssh/key.pub >> /root/.ssh/authorized_keys


export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644"
export K3S_KUBECONFIG_MODE="644"
curl -sfL https://get.k3s.io | sh -


