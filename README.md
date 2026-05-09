![CI Pipeline](https://github.com/dara-cod/magalu-desafio/actions/workflows/pipeline.yml/badge.svg)

# 🚀 Desafio Tatiana Dara - Magalu Cloud SRE Pleno

## 📚 Documentação

| Documento | Descrição |
|-----------|------------|
| [README.md](./README.md) | Visão geral do projeto |
| [ARGOCD.md](./ARGOCD.md) | Configuração GitOps com ArgoCD |

---

## 📌 Visão Geral

Este projeto demonstra a construção de um ambiente completo de infraestrutura cloud-native local, aplicando boas práticas de:

- SRE
- GitOps
- Infraestrutura como Código
- Segurança
- Observabilidade

A solução contempla provisionamento de cluster Kubernetes, gerenciamento de segredos com Vault, deploy via Helm, sincronização GitOps com ArgoCD e stack de observabilidade utilizando Prometheus + Grafana.

---

## 🧱 Arquitetura

- Kubernetes local com k3d
- Provisionamento via Terraform
- Deploy da aplicação com Helm
- GitOps com ArgoCD
- Secrets Management com Vault + External Secrets
- Observabilidade com Prometheus + Grafana
- Banco PostgreSQL via Docker Compose
- Pipeline CI com GitHub Actions
- Scan de vulnerabilidades com Trivy

---

## ⚙️ Stack Tecnológica

| Tecnologia | Objetivo |
|------------|-----------|
| Terraform | Infraestrutura como código |
| Kubernetes (k3d) | Cluster local |
| Helm | Gerenciamento de deploy |
| ArgoCD | GitOps |
| Vault | Gestão de segredos |
| External Secrets Operator | Integração Kubernetes + Vault |
| Docker Compose | Serviços auxiliares |
| PostgreSQL | Banco de dados |
| Grafana | Visualização e dashboards |
| Prometheus | Coleta de métricas |
| GitHub Actions | Pipeline CI |
| Trivy | Scan de vulnerabilidades |
| NGINX | Aplicação exemplo |

---

## 📁 Estrutura do Projeto

```text
magalu/
├── .github/
│   └── workflows/
├── app/
├── docker-compose/
│   └── prometheus/
├── helm/
│   └── magalu-app/
├── k8s/
├── terraform/
├── vault/
├── scripts/
├── evidencias/
├── README.md
├── ARGOCD.md
├── .env.example
├── .gitignore
└── Makefile
```

---

## 🔐 Gerenciamento de Variáveis

O projeto utiliza:

| Arquivo | Objetivo |
|----------|-----------|
| `.env` | Configuração local (não versionado) |
| `.env.example` | Template versionado |

---

## 🚀 Execução Rápida

```bash
make all
```

---

## ⚙️ Execução Passo a Passo

```bash
make setup      # sobe docker compose
make cluster    # cria cluster k3d
make terraform  # instala ingress nginx e argocd
make vault      # configura secrets no vault
make k8s        # aplica manifests kubernetes
make deploy     # deploy da aplicação via helm
make argocd     # aplica app gitops
```

---

## 🌐 Acessos

### 🟢 Aplicação

Adicionar ao `/etc/hosts`:

```bash
127.0.0.1 magalu.local
```

Acessar:

```text
http://magalu.local:8888
```

---

### 📊 Grafana

```text
http://localhost:3000
```

Usuário:

```text
admin
```

Senha definida no `.env`.

---

### 📈 Prometheus

```text
http://localhost:9090
```

---

### 🔐 Vault

```text
http://localhost:8200
```

Token:

```text
root
```

---

### 🚀 ArgoCD

Executar:

```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

Acessar:

```text
https://localhost:8081
```

Usuário:

```text
admin
```

Senha:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

---

## 🧪 Validação do Ambiente

### Kubernetes

```bash
kubectl get pods -n magalu
kubectl get ingress -n magalu
kubectl get externalsecrets -n magalu
```

---

### Aplicação

```bash
curl -H "Host: magalu.local" http://localhost:8888
```

---

### PostgreSQL

```bash
docker exec -it magalu-postgres psql -U sre-magalu -d db-magalu
```

Teste:

```sql
SELECT version();
SELECT 'Hello Magalu Cloud';
```

---

### Prometheus

Targets:

```text
Status → Targets → prometheus UP
```

---

## 🔑 Fluxo de Secrets

```text
Vault → External Secrets → Kubernetes → Aplicação
```

---

## 📊 Observabilidade

O ambiente possui stack de observabilidade com:

- Prometheus para coleta de métricas
- Grafana para dashboards e visualização
- Integração Prometheus + Grafana
- Dashboard configurado
- Datasource Prometheus validado

---

## 🚀 GitOps

O ArgoCD foi utilizado como estratégia GitOps para:

- sincronização declarativa
- gerenciamento contínuo do cluster
- controle de drift
- rastreabilidade de deploy

---

## 🔐 Segurança

O projeto aplica práticas de segurança como:

- ausência de secrets hardcoded
- uso de `.env`
- Vault como source of truth
- integração segura via External Secrets
- scan de vulnerabilidades com Trivy
- containers isolados
- `.gitignore` para proteção de credenciais

---

## 🔄 Pipeline CI

Pipeline implementado com GitHub Actions contendo:

- validação Terraform
- Terraform fmt
- Terraform validate
- Helm lint
- build Docker
- scan de vulnerabilidades com Trivy

---

## 🧠 Principais Desafios e Soluções

| Problema | Solução |
|-----------|----------|
| Conflito Helm vs ArgoCD | Definição de ownership único |
| Ingress não acessível | Mapeamento correto da porta no k3d |
| CrashLoopBackOff nginx | Ajuste de permissões e cache |
| Problemas de encoding UTF-8 | Ajuste no HTML |
| Variáveis não carregadas | Correção do contexto `.env` |
| Persistência do Grafana | Uso correto de Docker Volumes |
| Estrutura Prometheus | Ajuste de bind mount e paths |

---

## 📸 Evidências

Diretório:

```text
evidencias/
```

Inclui:

- aplicação funcionando
- pods Kubernetes
- ArgoCD sincronizado
- Prometheus UP
- dashboard Grafana
- PostgreSQL operacional
- pipeline GitHub Actions
- validações do ambiente

---
