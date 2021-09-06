# SG to allow traffic
resource "aws_security_group" "ingress" {
  name        = "kubernetes-ingress"
  description = "Kubernetes ingress traffic rules"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags
}

resource "aws_security_group_rule" "http" {
  description       = "Kubernetes HTTP access"
  security_group_id = aws_security_group.ingress.id
  type              = "ingress"
  from_port         = local.ingress_http_port
  to_port           = local.ingress_http_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https" {
  description       = "Kubernetes HTTPS access"
  security_group_id = aws_security_group.ingress.id
  type              = "ingress"
  from_port         = local.ingress_https_port
  to_port           = local.ingress_https_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "nginx_ingress_http" {
  description       = "Kubernetes ingress HTTP access"
  security_group_id = aws_security_group.ingress.id
  type              = "ingress"
  from_port         = local.nginx_ingress_http_port
  to_port           = local.nginx_ingress_http_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}



resource "aws_security_group_rule" "egress" {
  description       = "Kubernetes egress access"
  security_group_id = aws_security_group.ingress.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}