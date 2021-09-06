locals {
  worker_groups = [{
    instance_type                        = var.instance_type
    asg_max_size                         = var.max_size
    asg_min_size                         = var.min_size
    asg_desired_capacity                 = var.min_size
    autoscaling_enabled                  = true
    metadata_http_put_response_hop_limit = 2
    platform                             = "linux"
    # this will cause target groups to be recreated everytime plan runs
    target_group_arns = [
      var.http_target_group_arn
    ]
    tags = [
      {
        "key"                 = "k8s.io/cluster-autoscaler/enabled"
        "propagate_at_launch" = "false"
        "value"               = ""
      },
      {
        "key"                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
        "propagate_at_launch" = "false"
        "value"               = ""
      }
    ]
  }]

  # placeholder for two big RBAC roles
  # roles = {
  #     "reader" = [
  #     {
  #         api_groups = [""]
  #         resources  = ["namespaces"]
  #         verbs      = ["get", "watch", "list"]
  #     }
  #     ]
  #     "admin" = [
  #     {
  #         api_groups = ["", "extensions", "apps"]
  #         resources  = ["pods", "pods/log", "services", "endpoints", "configmaps", "secrets", "deployments", "ingresses"]
  #         verbs      = ["*"]
  #     }
  #     ]
  # }

  default_kubernetes_roles = [
    {
      rolearn  = ""
      username = "admin"
      groups   = ["system:masters"]
    },
  ]
  #   kubernetes_roles = concat(
  #     local.default_kubernetes_roles[data.aws_caller_identity.current.account_id]
  # )

  tags = {
    Terraform   = "true"
    Owner       = "Vladyslav"
    Environment = "demo"
  }
}