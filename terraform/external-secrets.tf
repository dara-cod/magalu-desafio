resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  namespace  = "magalu"

  version = "0.9.11"  

  depends_on = [kubernetes_namespace_v1.magalu]
}