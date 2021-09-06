output "vpc_id" {
  value = module.vpc.vpc_id
}

output "kubernetes_nlb_http_arn" {
  value = aws_lb_target_group.kubernetes_nlb_http.arn
}

output "kubernetes_nlb_dns" {
  value = aws_lb.kuberentes_nlb.dns_name
}

output "ingress_sg_id" {
  value = aws_security_group.ingress.id
}
output "private_subnets_ids" {
  value = module.vpc.private_subnets
}