output "vpc_id" {
  value = module.initial_configuration.vpc_id
}

output "listener_target_group" {
  value = module.initial_configuration.kubernetes_nlb_http_arn
}

output "eks_endpoint" {
  value = module.eks.eks_endpoint
}

# output "eks_endpoint_ca" {
#   value = module.eks.eks_endpoint_ca
# }

output "private_sn_ids" {
  value = module.initial_configuration.private_subnets_ids
}
