variable "eks_cluster_name" {
  type = string
  description = "EKS cluster name"
}

variable "eks_cluster_endpoint" {
  type = string
  description = "EKS control plane endpoint"
}

variable "eks_cluster_ca" {
  type = string
  description = "Kuberentes api server certificate data"
}

variable "eks_auth_token" {
  type        = string
  description = "STS granted auth token."
}