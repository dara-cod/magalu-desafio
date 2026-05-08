Boa — você chegou na fase final: **documentação + fechamento do projeto**.
E tem um ponto importante que você mesma já identificou:

👉 **não existe Ingress criado → então o acesso via domínio não vai funcionar ainda**

Vou te entregar um README **corrigido, completo e nível aprovação**, já refletindo tudo que você aprendeu (inclusive esse detalhe do ingress).

---

# 📄 README.md — VERSÃO FINAL (ATUALIZADA)

```markdown
# 🚀 Magalu Cloud SRE Challenge

## 📌 Objetivo

Provisionar uma infraestrutura resiliente local utilizando Kubernetes, Vault, Observabilidade e CI/CD, seguindo boas práticas de SRE.

---

## 🧱 Arquitetura

A arquitetura foi desenhada separando responsabilidades entre infraestrutura, segurança e aplicação.

📁 Todos os diagramas estão na pasta:

```

evidencias/

````

---

## ⚙️ Stack utilizada

- Terraform (IaC)
- K3d (Kubernetes local)
- Helm (Deploy da aplicação)
- ArgoCD (GitOps)
- Vault (Secrets)
- External Secrets Operator
- PostgreSQL (Docker)
- Prometheus + Grafana
- FastAPI (Python)

---

## 🛠️ Instalação de dependências (Ubuntu)

```bash
chmod +x scripts/install.sh
./scripts/install.sh
````

Validar instalação:

```bash
docker -v
kubectl version --client
helm version
terraform -v
k3d version
vault -v
make -v
```

---

## 🚀 Como executar o projeto

### 1. Clonar repositório

```bash
git clone https://github.com/dara-cod/magalu-desafio
cd magalu-desafio
```

---

### 2. Configurar ambiente

```bash
cp .env.example .env
```

---

### 3. Execução completa

```bash
make all
```

---

## ⚙️ Execução passo a passo (debug)

```bash
make setup     # sobe docker (vault, postgres, grafana)
make cluster   # cria cluster k3d
make terraform # instala ingress-nginx, external-secrets, argocd
make vault     # configura secrets no vault
make k8s       # aplica secretstore + externalsecret
make deploy    # deploy da aplicação via helm
make argocd    # gitops
```

---

## 🌐 Acessos

### 🟢 Aplicação

⚠️ IMPORTANTE:

Neste projeto o Ingress Controller é provisionado via Terraform, porém o recurso de Ingress da aplicação não foi criado, portanto o acesso ocorre via Service.

👉 Acesse via NodePort:

```bash
kubectl get svc -n magalu
```

Exemplo:

```
80:30506
```

Acessar:

```
http://localhost:30506
```

---

### 📊 Grafana

```
http://localhost:3000
```

* user: admin
* senha: definida no `.env`

---

### 🔐 Vault

```
http://localhost:8200
```

Token:

```
root
```

---

## 🧪 Validação

### Kubernetes

```bash
kubectl get pods -n magalu
```

✔️ Esperado:

* app rodando
* external-secrets rodando

---

### Secret

```bash
kubectl get secret magalu-secret -n magalu
```

✔️ External Secrets sincronizado

---

### App (env)

```bash
kubectl exec -it <pod-app> -n magalu -- env | grep username
```

---

### PostgreSQL

```bash
docker exec -it magalu-postgres psql -U sre-magalu -d db-magalu
```

```sql
SELECT 'Hello Magalu Cloud';
```

---

### Vault

```bash
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root

vault kv get secret/magalu
```

---

## 🚀 GitOps com ArgoCD

```bash
make argocd
```

Acessar:

```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

```
https://localhost:8081
```

Senha:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

---

## 🔐 Segurança

* Nenhum secret hardcoded
* Uso de `.env` apenas para bootstrap local
* Vault como fonte de verdade
* External Secrets para sincronização
* Containers rodando como non-root
* Preparado para AWS Secrets Manager
* Scan com Trivy na pipeline

💡 Para ambiente local usei `.env` e preparei a arquitetura para migrar para Vault / External Secrets em produção.

---

## 📦 Estrutura

```
app/
docker-compose/
helm/
k8s/
terraform/
vault/
scripts/
evidencias/
```

---

## 📸 Evidências

Todos os prints exigidos estão em:

```
evidencias/
```

---

## 📊 Observabilidade

* Prometheus via Helm
* Grafana externo via Docker

---

## 🔑 Fluxo de Secrets

```
Vault → External Secrets → Kubernetes → Aplicação
```

---

## ⚙️ Automação

```bash
make all
```

---

## 🧠 Lições Aprendidas

* Importância de separar responsabilidade entre Terraform e Helm
* External Secrets requer:

  * token válido
  * policy correta (data + metadata)
  * path correto (KV v2)
* Helm exige estrutura correta de chart (`Chart.yaml + templates`)
* Ordem de execução impacta diretamente na disponibilidade dos recursos
* Debug via logs (`kubectl logs`) é essencial em troubleshooting
* Evitar criação manual de recursos → sempre IaC

---

## 🧠 Decisões técnicas

* K3d → leve e rápido para ambiente local
* External Secrets → padrão moderno de integração com Vault
* ArgoCD → GitOps declarativo
* Vault → centralização de secrets
* Helm → padronização de deploy
* Terraform → controle da infraestrutura

---

## 🚀 Melhorias futuras

* Criar Ingress da aplicação
* TLS com cert-manager
* HPA (autoscaling)
* Deploy real com FastAPI (substituir nginx)
* Integração com AWS Secrets Manager

```

---

