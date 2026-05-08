#!/bin/bash

set -e

echo "🔧 Atualizando pacotes..."
sudo apt update -y

# Dependências básicas
echo "📦 Verificando dependências básicas..."
for pkg in curl unzip apt-transport-https ca-certificates gnupg lsb-release; do
  if ! dpkg -l | grep -q "$pkg"; then
    echo "➡️ Instalando $pkg..."
    sudo apt install -y $pkg
  else
    echo "✔️ $pkg já instalado"
  fi
done

# Docker
if ! command -v docker &> /dev/null; then
  echo "🐳 Instalando Docker..."
  sudo apt install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo usermod -aG docker $USER
else
  echo "✔️ Docker já instalado"
fi

# kubectl
if ! command -v kubectl &> /dev/null; then
  echo "📦 Instalando kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
else
  echo "✔️ kubectl já instalado"
fi

# Helm
if ! command -v helm &> /dev/null; then
  echo "📦 Instalando Helm..."
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
  echo "✔️ Helm já instalado"
fi


# Terraform
if ! command -v terraform &> /dev/null; then
  echo "📦 Instalando Terraform..."
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository -y "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt update && sudo apt install -y terraform
else
  echo "✔️ Terraform já instalado"
fi


# k3d
if ! command -v k3d &> /dev/null; then
  echo "📦 Instalando k3d..."
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
else
  echo "✔️ k3d já instalado"
fi

# Vault CLI

if ! command -v vault &> /dev/null; then
  echo "📦 Instalando Vault CLI..."
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository -y "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt update && sudo apt install -y vault
else
  echo "✔️ Vault já instalado"
fi


# Make
if ! command -v make &> /dev/null; then
  echo "📦 Instalando Make..."
  sudo apt install -y make
else
  echo "✔️ Make já instalado"
fi

echo ""
echo "✅ Instalação concluída!"
echo "⚠️ Se Docker foi instalado agora, execute:"
echo "   newgrp docker"
echo "   ou reinicie o terminal"