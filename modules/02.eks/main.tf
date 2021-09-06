module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.11.0"

  cluster_version                      = "1.20"
  cluster_name                         = var.cluster_name
  worker_groups_launch_template        = local.worker_groups
  worker_additional_security_group_ids = var.ingress_security_group_ids
  tags                                 = local.tags

  vpc_id  = var.vpc_id
  subnets = var.private_subnets

  #   map_roles = local.roles
}

# TODO organize this nicer
# Custom namespace for infra services
resource "kubernetes_namespace" "cluster_service" {
  metadata {
    name = "cluster-services"
  }
}


# cluster autoscaler policy creation/attachment
resource "aws_iam_policy" "autoscaler" {
  name   = "${var.cluster_name}-autoscaler"
  policy = data.aws_iam_policy_document.autoscaler.json
}

resource "aws_iam_policy_attachment" "autoscaler_policy_attachment" {
  name       = "${var.cluster_name}-autoscaler-attachment"
  roles      = [module.eks.worker_iam_role_name]
  policy_arn = aws_iam_policy.autoscaler.arn
}