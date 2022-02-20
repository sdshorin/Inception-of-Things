openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -key rootCA.key -days 10000 -out rootCA.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=21Security/OU=21/CN=21.ru"

openssl genrsa -out rootM.key 2048
openssl req -x509 -new -key rootM.key -days 10000 -out rootM.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=21Security/OU=21/CN=minio.21.ru"

openssl genrsa -out rootG.key 2048
openssl req -x509 -new -key rootG.key -days 10000 -out rootG.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=21Security/OU=21/CN=gitlab.21.ru"


/usr/local/bin/kubectl create ns gitlab-system
/usr/local/bin/kubectl -n gitlab-system create secret tls gitlab-gitlab-tls \
--cert=/home/vagrant/rootG.crt \
--key=/home/vagrant/rootG.key
/usr/local/bin/kubectl -n gitlab-system create secret tls gitlab-registry-tls \
--cert=/home/vagrant/rootCA.crt \
--key=/home/vagrant/rootCA.key
/usr/local/bin/kubectl -n gitlab-system create secret tls gitlab-minio-tls \
--cert=/home/vagrant/rootM.crt \
--key=/home/vagrant/rootM.key
/usr/local/bin/kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.0/cert-manager.yaml
/usr/local/bin/kubectl wait --for=condition=available deployment --all -n cert-manager --timeout=3m
/usr/local/bin/kubectl wait --for=condition=ready pod --all -n cert-manager --timeout=3m
/usr/local/bin/kubectl apply -f https://gitlab.com/api/v4/projects/18899486/packages/generic/gitlab-operator/0.4.1/gitlab-operator-kubernetes-0.4.1.yaml
/usr/local/bin/kubectl wait --for=condition=available deployment --all -n gitlab-system --timeout=3m
/usr/local/bin/kubectl wait --for=condition=ready pod --all -n gitlab-system --timeout=3m
/usr/local/bin/kubectl apply -f /home/vagrant/confs/gitlab.yaml -n gitlab-system
/usr/local/bin/kubectl wait --for=condition=available deployment --all -n gitlab-system --timeout=4m
/usr/local/bin/kubectl wait --for=condition=ready pod --all -n gitlab-system --timeout=4m
/usr/local/bin/kubectl -n gitlab-system get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo
