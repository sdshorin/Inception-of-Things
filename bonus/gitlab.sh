# устанавливаем helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# создаем namespace
kubectl create namespace gitlab


# устанавливаем гитлаб
git clone https://gitlab.com/gitlab-org/charts/gitlab.git
cd gitlab
cp examples/values-minikube-minimum.yaml ./
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm dependency update -n gitlab
helm upgrade --install gitlab -f values-minikube-minimum.yaml . --timeout 600s --set global.hosts.domain=gitlab.bjesse --set global.edition=ce --set global.hosts.externalIP=192.168.42.110 -n gitlab
