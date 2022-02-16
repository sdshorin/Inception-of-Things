#!/bin/bash

echo "Hi here!!"
cat /home/vagrant/.ssh/id_rsa.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cp -R  /home/vagrant/.ssh/*  /root/.ssh

yum install -y net-tools

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --node-ip 192.168.42.110"
export K3S_KUBECONFIG_MODE="644"
curl -sfL https://get.k3s.io | sh -

/usr/local/bin/kubectl apply -f /home/vagrant/confs/app1/configmap.yaml
/usr/local/bin/kubectl apply -f /home/vagrant/confs/app1/deployment.yaml
/usr/local/bin/kubectl apply -f /home/vagrant/confs/app2/configmap.yaml
/usr/local/bin/kubectl apply -f /home/vagrant/confs/app2/deployment.yaml
/usr/local/bin/kubectl apply -f /home/vagrant/confs/app3/configmap.yaml
/usr/local/bin/kubectl apply -f /home/vagrant/confs/app3/deployment.yaml
/usr/local/bin/kubectl apply -f /home/vagrant/confs/services.yaml
/usr/local/bin/kubectl apply -f /home/vagrant/confs/ingress.yaml

#/usr/local/bin/kubectl create namespace p2
#/usr/local/bin/kubectl -n p2 apply -f /home/vagrant/confs/app1/configmap.yaml
#/usr/local/bin/kubectl -n p2 apply -f /home/vagrant/confs/app1/deployment.yaml
#/usr/local/bin/kubectl -n p2 apply -f /home/vagrant/confs/app2/configmap.yaml
#/usr/local/bin/kubectl -n p2 apply -f /home/vagrant/confs/app2/deployment.yaml
#/usr/local/bin/kubectl -n p2 apply -f /home/vagrant/confs/app3/configmap.yaml
#/usr/local/bin/kubectl -n p2 apply -f /home/vagrant/confs/app3/deployment.yaml
#/usr/local/bin/kubectl -n p2 apply -f /home/vagrant/confs/services.yaml
#/usr/local/bin/kubectl -n p2 apply -f /home/vagrant/confs/ingress.yaml

# k3s kubectl get nodes -o wide
