- [ArgoCD Setup](./ARGOCD.md)

## 🚀 GitOps com ArgoCD

O ArgoCD foi configurado para gerenciar o deploy da aplicação via GitOps.

### Acesso ao ArgoCD

```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

Acesse:

https://localhost:8081

### Credenciais

* Usuário: admin

Senha:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

### Funcionamento

O ArgoCD monitora o repositório e sincroniza automaticamente:

* Helm chart da aplicação
* Configurações do Kubernetes
* Atualizações de deploy
