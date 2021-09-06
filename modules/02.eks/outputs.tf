output "eks_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_endpoint_ca" {
  value = module.eks.cluster_certificate_authority_data
  # sensitive   = true # annotated because this value will be transfered to other module
}