resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.10.6"
  # static values are defined in yaml file 
  # dynamic values are defined explicitly
  values = [
    "${file("${path.module}/files/configuration/cluster-autoscaler.yaml")}"
  ]

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

}

# No real reasons for nginx ingress
# probably because its the most old one available

# Note: it creates classic LB outside of basic configuration
# TODO: should be suppressed

resource "helm_release" "ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.1"
  namespace = "cluster-services"

  values = [
    "${file("${path.module}/files/configuration/nginx-ingress.yaml")}"
  ]

}

# resource "helm_release" "ingress" {
#   name       = "traefik"
#   repository = "https://helm.traefik.io/traefik"
#   chart      = "traefik"
#   version    = "9.15.2"
#   namespace = "cluster-services"

#   values = [
#     templatefile("${path.module}/files/configuration/traefik-ingress.yaml",
#       {
#         ingress_dns_endpoint = var.nlb_endpoint
#       }
#     )
#   ]
# }