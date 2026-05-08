.PHONY: setup cluster terraform vault k8s deploy argocd all

setup:
	docker compose -f docker-compose/docker-compose.yml up -d

cluster:
	k3d cluster create magalu \
	  --servers 1 \
	  --agents 1 \
	  --image rancher/k3s:v1.28.8-k3s1 \
	  --port "8888:80@loadbalancer" \
	  --k3s-arg "--disable=traefik@server:0" || true

	k3d kubeconfig merge magalu --kubeconfig-switch-context
	kubectl wait --for=condition=Ready nodes --all --timeout=120s

terraform:
	cd terraform && terraform init && terraform apply -auto-approve

vault:
	bash vault/setup.sh

k8s:
	kubectl create namespace magalu || true
	kubectl apply -f k8s/vault-token.yaml
	kubectl apply -f k8s/

deploy:
	helm upgrade --install magalu ./helm/magalu-app -n magalu

argocd:
	kubectl apply -f k8s/argocd-app.yaml

all: setup cluster terraform vault k8s deploy argocd