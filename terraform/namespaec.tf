resource "kubernetes_namespace_v1" "magalu" {
  metadata {
    name = "magalu"
  }
}