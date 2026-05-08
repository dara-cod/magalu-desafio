![CI Pipeline](https://github.com/dara-cod/magalu-desafio/actions/workflows/pipeline.yml/badge.svg)

# 🚀 Desafio Tatiana Dara - Magalu Cloud SRE Pleno

## 📚 Documentação

| Documento | Descrição |
|-----------|------------|
| [README.md](./README.md) | Visão geral do projeto |
| [ARGOCD.md](./ARGOCD.md) | Configuração GitOps com ArgoCD |

---

## 📌 Visão Geral

Este projeto demonstra a construção de um ambiente completo de **infraestrutura cloud-native local**, aplicando boas práticas de **SRE, GitOps, segurança e observabilidade**.

A solução inclui provisionamento de cluster Kubernetes, gerenciamento de segredos com Vault, deploy com Helm, sincronização com ArgoCD e visualização via Grafana.

---

## 🧱 Arquitetura

* Kubernetes local com k3d
* Provisionamento via Terraform
* Deploy de aplicação com Helm
* GitOps com ArgoCD
* Gestão de segredos com Vault + External Secrets
* Observabilidade com Grafana
* Banco de dados PostgreSQL via Docker

---

## ⚙️ Stack Tecnológica

* **Terraform** — Infraestrutura como código
* **K3d (Kubernetes)** — Cluster local
* **Helm** — Gerenciamento de deploy
* **ArgoCD** — GitOps
* **Vault** — Gestão de segredos
* **External Secrets Operator** — Integração com Kubernetes
* **Docker Compose** — Serviços auxiliares
* **Grafana** — Observabilidade
* **NGINX** — Aplicação de exemplo

---

## 📁 Estrutura do Projeto

```
magalu/
├── docker-compose/
├── helm/
│   └── magalu-app/
├── k8s/
├── terraform/
├── vault/
├── scripts/
├── evidencias/
├── .env
├── .env.example
└── Makefile
```

---

## 🔐 Gerenciamento de Variáveis

O projeto utiliza:

* `.env` → configuração local (não versionado)
* `.env.example` → template versionado

---

## 🚀 Execução Rápida

```bash
make all
```

---

## ⚙️ Execução Passo a Passo

```bash
make setup      # sobe docker (vault, postgres, grafana)
make cluster    # cria cluster k3d
make terraform  # instala ingress e argocd
make vault      # configura secrets no vault
make k8s        # aplica manifests (external secrets)
make deploy     # deploy da aplicação via helm
make argocd     # aplica aplicação gitops
```

---

## 🌐 Acessos

### 🟢 Aplicação

Adicionar ao `/etc/hosts`:

```bash
127.0.0.1 magalu.local
```

Acessar:

```
http://magalu.local:8888
```

---

### 📊 Grafana

```
http://localhost:3000
```

* user: `admin`
* senha: definida no `.env`

---

### 🔐 Vault

```
http://localhost:8200
```

* token: `root`

---

### 🚀 ArgoCD

```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

Acessar:

```
https://localhost:8081
```

Senha:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

---

## 🧪 Validação do Ambiente

```bash
kubectl get pods -n magalu
kubectl get externalsecrets -n magalu
kubectl get ingress -n magalu
```

Teste da aplicação:

```bash
curl -H "Host: magalu.local" http://localhost:8888
```

---

## 🔑 Fluxo de Secrets

```
Vault → External Secrets → Kubernetes → Aplicação
```

---

## 📊 Observabilidade

* Dashboard configurado no Grafana
* Visualização de status da aplicação
* Estrutura pronta para integração com Prometheus

---

## 🚀 GitOps

* ArgoCD sincroniza estado do cluster com repositório
* Estratégia declarativa de deploy
* Evita drift de configuração

---

## 🔐 Segurança

* Sem secrets hardcoded
* Uso de `.env` para bootstrap
* Vault como source of truth
* External Secrets para integração segura
* Containers isolados

---

## 🧠 Principais Desafios e Soluções

| Problema                  | Solução                                |
| ------------------------- | -------------------------------------- |
| Conflito Helm vs ArgoCD   | Definição de ownership único           |
| Erro de portas (Service)  | Ajuste de targetPort                   |
| CrashLoopBackOff no nginx | Volume para cache (`emptyDir`)         |
| Problemas de encoding     | Definição de UTF-8 no HTML             |
| Variáveis não carregadas  | Ajuste do `.env` e contexto do compose |
| Persistência do Grafana   | Reset de volume                        |

---

## 📸 Evidências

Diretório:

```
evidencias/
```

Inclui:

* aplicação funcionando
* pods em execução
* ArgoCD sincronizado
* dashboard Grafana

---

