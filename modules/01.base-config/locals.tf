# Static definitions comes here
locals {
  nginx_ingress_http_port  = 30001 # nginx default value
  ingress_http_port  = 80
  ingress_https_port = 443

  tags = {
    Terraform   = "true"
    Owner       = "Vladyslav"
    Environment = "demo"
  }
}
