#!/bin/bash

set -e

export VAULT_ADDR=${VAULT_ADDR:-http://localhost:8200}
export VAULT_TOKEN=${VAULT_TOKEN:-root}

# Não hardcode — usa env ou fallback seguro
DB_USER=${POSTGRES_USER:-sre-magalu}
DB_PASS=${POSTGRES_PASSWORD:-$(openssl rand -base64 16)}

echo "[INFO] Configurando Vault..."

# --------------------------------------------------
# Habilita KV v2 (idempotente)
# --------------------------------------------------
if ! vault secrets list | grep -q "secret/"; then
  echo "[INFO] Habilitando KV v2..."
  vault secrets enable -path=secret kv-v2
else
  echo "[INFO] KV já habilitado"
fi


echo "[INFO] Criando secret no Vault..."
vault kv put secret/magalu \
  username="$DB_USER" \
  password="$DB_PASS"


echo "[INFO] Criando policy..."
vault policy write magalu-policy - <<EOF
path "secret/data/magalu" {
  capabilities = ["read"]
}

path "secret/metadata/magalu" {
  capabilities = ["read"]
}
EOF

echo "[INFO] Vault configurado com sucesso!"