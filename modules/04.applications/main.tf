# Deploying apps via terraform is overhead - better to avoid doing this
# there are a bunch of other tools that are doing this tasks much better

# Using it for demo purposes
resource "kubernetes_namespace" "kafka" {
  metadata {
    name = "kafka"
  }
}

resource "helm_release" "kafka" {
  name       = "kafka"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  version    = "14.0.5"
  namespace = "kafka"

  #   values = [
  #   "${file("${path.module}/files/configuration/nginx-ingress.yaml")}"
  # ]

}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "grafana"
  version    = "6.1.11"
  namespace = "default"
  values = [
     templatefile("${path.module}/files/configuration/grafana-tmpl.yaml",
        {
          hostname = var.nlb_endpoint
        }
     )
  ]
}