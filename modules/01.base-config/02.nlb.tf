resource "aws_eip" "kuberentes_lb_ips" {
  count = length(var.public_subnets)
  vpc   = true
  tags  = local.tags
}

resource "aws_lb" "kuberentes_nlb" {
  name               = "kuberentes-nlb"
  load_balancer_type = "network"
  internal           = false

  dynamic "subnet_mapping" {
    for_each = [
      for key, subnet in module.vpc.public_subnets : {
        subnet_id     = subnet
        allocation_id = aws_eip.kuberentes_lb_ips[key].id
      }
    ]

    content {
      subnet_id     = subnet_mapping.value.subnet_id
      allocation_id = subnet_mapping.value.allocation_id
    }
  }

  tags = local.tags
}

# lifecycle should be fixed here
resource "aws_lb_target_group" "kubernetes_nlb_http" {
  name                 = "kuberentes-nlb-http"
  port                 = local.nginx_ingress_http_port
  protocol             = "TCP"
  vpc_id               = module.vpc.vpc_id
  target_type          = "instance"
  deregistration_delay = 90

  health_check {
    interval            = 10
    port                = local.nginx_ingress_http_port
    protocol            = "TCP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = local.tags
}

resource "aws_lb_listener" "kubernetes_nlb_http" {
  load_balancer_arn = aws_lb.kuberentes_nlb.arn
  port              = local.ingress_http_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kubernetes_nlb_http.arn
  }
}

# this requires domain to be registered and few more route53 components
# to be created in advance
# DNS hosted zone
# TLS certificates

# resource "aws_lb_target_group" "kubernetes_nlb_https" {
#   name                 = "kuberentes-nlb-https"
#   port                 = local.ingress_https_port
#   protocol             = "TLS"
#   vpc_id               = module.vpc.vpc_id
#   target_type          = "instance"
#   deregistration_delay = 90

#   health_check {
#     interval            = 10
#     port                = local.ingress_https_port
#     protocol            = "TCP"
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#   }

#   tags = local.tags
# }

# resource "aws_lb_listener" "kubernetes_nlb_https" {
#   load_balancer_arn = aws_lb.kuberentes_nlb.arn
#   port              = local.ingress_https_port
#   protocol          = "TLS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = unknown

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.kubernetes_nlb_https.arn
#   }
# }