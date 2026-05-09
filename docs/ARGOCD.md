# 🚀 ArgoCD GitOps

Este projeto utiliza o ArgoCD para gerenciamento declarativo e sincronização contínua do ambiente Kubernetes seguindo o modelo GitOps.

---

## 📌 Objetivo

O ArgoCD monitora o repositório Git e aplica automaticamente alterações no cluster Kubernetes, garantindo consistência entre infraestrutura e código versionado.

---

## 🧱 Recursos Gerenciados

O ArgoCD sincroniza automaticamente:

- Helm chart da aplicação
- Configurações Kubernetes
- Atualizações de deployment
- Recursos declarativos do cluster

---

## 🚀 Acesso ao ArgoCD

Execute o port-forward:

```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

Acesse:

```text
https://localhost:8081
```

---

## 🔐 Credenciais

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

## 📊 Validação

Verificar aplicações sincronizadas:

```bash
kubectl get applications -n argocd
```

Resultado esperado:

```text
NAME         SYNC STATUS   HEALTH STATUS
magalu-app   Synced        Healthy
```

---

## 🔄 Fluxo GitOps

```text
Git Repository → ArgoCD → Kubernetes Cluster
```

---

## ✅ Benefícios

- Deploy declarativo
- Sincronização automática
- Redução de drift de configuração
- Melhor rastreabilidade
- Controle centralizado de aplicações

---

## 🧠 Observações

O ArgoCD foi utilizado como estratégia GitOps para garantir maior confiabilidade no gerenciamento do ambiente Kubernetes.