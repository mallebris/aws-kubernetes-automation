data "aws_eks_cluster" "k8s_cluster" {
  name = local.cluster_name
}

data "aws_eks_cluster_auth" "k8s_cluster" {
  name = local.cluster_name
}