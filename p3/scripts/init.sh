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

#echo "Устанавливаем AgroCD в класстер k3d"
/usr/local/bin/kubectl create namespace argocd
/usr/local/bin/kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
/usr/local/bin/kubectl -n argocd patch svc/argocd-server -p '{"spec": {"type": "LoadBalancer"}}'
/usr/local/bin/kubectl wait --for=condition=available deployment --all -n argocd --timeout=3m
/usr/local/bin/kubectl wait --for=condition=ready pod --all -n argocd --timeout=3m
#echo "Парроль ArgoCD"
/usr/local/bin/kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath={.data.password} | base64 --decode

/usr/local/bin/kubectl apply -f /home/vagrant/confs/argocd.yaml
#После запуска ВМ можно подключится и пробрасить порты
#kubectl port-forward svc/argocd-server -n argocd 8888:80  --address=0.0.0.0
#kubectl port-forward svc/argocd-server -n argocd 8443:443 --address=0.0.0.0
