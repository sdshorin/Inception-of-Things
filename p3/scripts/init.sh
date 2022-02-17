#!/bin/bash

sudo cat /home/vagrant/.ssh/id_rsa.pub  >> /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
sudo cp -R  /home/vagrant/.ssh/*  /root/.ssh

echo "скачиваем и запускаем докер"
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh
sudo usermod -aG docker $USER
sudo service docker start
sudo chmod 666 /var/run/docker.sock

echo "Устанавливаем kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Устанавливаем k3d"
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
k3d cluster create mycluster
# k3d cluster create mycluster -p 8080:80@loadbalancer

echo "Устанавливаем AgroCD"
/usr/local/bin/kubectl create namespace argocd
/usr/local/bin/kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
/usr/local/bin/kubectl wait --for=condition=available deployment --all -n argocd --timeout=60m
/usr/local/bin/kubectl wait --for=condition=Ready pods --all -n argocd --timeout=60m

echo "port-forward 8080:80"
/usr/local/bin/kubectl port-forward svc/argocd-server -n argocd 8080:80 & #  --address=0.0.0.0 &
echo "port-forward 8443:443"
/usr/local/bin/kubectl port-forward svc/argocd-server -n argocd 8443:443 & # --address=0.0.0.0 &

echo "Password ArgoCD"
/usr/local/bin/kubectl get pods -n argocd | grep argocd-server

sudo mkdir /root/.kube
sudo cp /home/vagrant/.kube/config  /root/.kube/config
# /usr/local/bin/kubectl port-forward svc/argocd-server -n argocd 8080:443&