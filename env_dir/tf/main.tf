# Because of project size the modules are not separated into different layers,
# thats why everything in one state file - which is not the best setup 
# for real production
# In production it should be in different state files in order to satisfy
# granular changes flow

module "initial_configuration" {
  # this is a raw module usage - preferebly using versioning.
  #In terraform it means using versioning based on git tags
  source = "../../modules/01.base-config"

  az_list  = ["us-east-2a", "us-east-2b", "us-east-2c"]
  vpc_cidr = "10.0.0.0/16"

  # alternatively can be used this function: https://www.terraform.io/docs/language/functions/cidrsubnet.html
  # in order to make it simple left an explicit definition
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "eks" {
  source = "../../modules/02.eks"

  cluster_name               = local.cluster_name
  vpc_id                     = module.initial_configuration.vpc_id
  private_subnets            = module.initial_configuration.private_subnets_ids
  instance_type              = "t3.medium"
  max_size                   = 6
  min_size                   = 3
  http_target_group_arn      = module.initial_configuration.kubernetes_nlb_http_arn
  ingress_security_group_ids = [module.initial_configuration.ingress_sg_id]
}

module "k8s-services" {
  source = "../../modules/03.kubernetes-services"

  eks_cluster_name     = local.cluster_name
  eks_cluster_endpoint = module.eks.eks_endpoint
  eks_cluster_ca       = module.eks.eks_endpoint_ca
  eks_auth_token       = data.aws_eks_cluster_auth.k8s_cluster.token
  nlb_endpoint         = module.initial_configuration.kubernetes_nlb_dns
}

module "applications" {
  source = "../../modules/04.applications"

  eks_cluster_endpoint = module.eks.eks_endpoint
  eks_cluster_ca       = module.eks.eks_endpoint_ca
  eks_auth_token       = data.aws_eks_cluster_auth.k8s_cluster.token
  nlb_endpoint         = module.initial_configuration.kubernetes_nlb_dns
}