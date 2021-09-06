variable "eks_cluster_endpoint" {
  type = string
}

variable "eks_cluster_ca" {
  type = string
}

variable "eks_auth_token" {
  type        = string
}

variable "nlb_endpoint" {
  type        = string
  description = "For web UI DNS is required. NLB will be the DNS host for web services"
}