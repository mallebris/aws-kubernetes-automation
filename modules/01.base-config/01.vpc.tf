resource "aws_eip" "nat" {
  vpc = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name}-vpc"
  cidr = var.vpc_cidr

  azs             = var.az_list
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway  = true
  single_nat_gateway  = true
  reuse_nat_ips       = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"

  tags = local.tags
}