output shared {
  value = {
    environment  = local.environment
    region       = local.region
    account_id   = local.account_id
    cluster_name = local.cluster_name
    cluster_id   = module.eks.cluster_id

    // TODO: use namespace.xxx
    kubeca_namespace = local.kubeca_namespace
    hb_namespace  = local.hb_namespace
    jobs_namespace   = local.jobs_namespace

    //cluster_shared_volume_id  = shared aws_ebs_volume.hb-cluster-shared.*.id
    //cluster_shared_volume_arn = shared aws_ebs_volume.hb-cluster-shared.*.arn
  } 
}

output cluster {
  value = {
    cluster_id                         = module.eks.cluster_id
    cloudwatch_log_group_arn           = module.eks.cloudwatch_log_group_arn
    cluster_primary_security_group_id  = module.eks.cluster_primary_security_group_id
    cluster_arn                        = module.eks.cluster_arn
    cluster_endpoint                   = module.eks.cluster_endpoint
    cluster_iam_role_arn               = module.eks.cluster_iam_role_arn
    cluster_version                    = module.eks.cluster_version
    cluster_oidc_issuer_url            = module.eks.cluster_oidc_issuer_url
    cluster_security_group_arn         = module.eks.cluster_security_group_arn
    cluster_security_group_id          = module.eks.cluster_security_group_id
    cluster_version                    = module.eks.cluster_version
    node_security_group_id             = module.eks.node_security_group_id
    node_security_group_arn            = module.eks.node_security_group_arn
    cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
    cluster_iam_role_name              = module.eks.cluster_iam_role_name
    default_node_group_iam_role_name   = module.eks.eks_managed_node_groups.default_node_group.iam_role_name
    oidc_provider                      = module.eks.oidc_provider
    oidc_provider_arn                  = module.eks.oidc_provider_arn
  }
}

#output node_groups {
#  value = {
#     self_managed = module.eks.self_managed_node_groups
#     eks_managed  = module.eks.eks_managed_node_groups
#   }
# }


output namespace {
  value = {
    kubeca = local.kubeca_namespace
    hb  = local.hb_namespace
    jobs   = local.jobs_namespace
  }
}