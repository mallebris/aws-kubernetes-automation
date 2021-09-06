variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "Target VPC ID for placing workers"
}

variable "private_subnets" {
  type = list(string)
}


variable "instance_type" {
  type        = string
  description = "AWS instance type for eks cluster"
}

variable "max_size" {
  type        = number
  description = "EKS worker plane max size"
}

variable "min_size" {
  type        = number
  description = "EKS worker plane min size"
}

variable "http_target_group_arn" {
  type        = string
  description = "NLB target group arn"
}

variable "ingress_security_group_ids" {
  type = list(string)
}