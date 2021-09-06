variable "eks_cluster_endpoint" {
  type        = string
  description = "EKS control plane endpoint"
}

variable "eks_cluster_ca" {
  type        = string
  description = "Kuberentes api server certificate data"
}

variable "eks_auth_token" {
  type        = string
  description = "STS granted auth token."
}

variable "nlb_endpoint" {
  type        = string
  description = "For web UI DNS is required. NLB will be the DNS host for web services"
}