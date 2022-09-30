
output shared {
  value = module.deploy-eks.shared
}

output cluster {
  value = module.deploy-eks.cluster
}

#output node_groups {
#  value = module.deploy-eks.node_groups
#}

output k8s {
  value = "aws eks --region ${module.deploy-eks.shared.region} update-kubeconfig --name ${module.deploy-eks.shared.cluster_name}"
}

output namespace {
  value = module.deploy-eks.namespace
}

output remote_state {
  value = {
    bucket = "hb-test-terraform"
    key    = "dev/hb-test-eks-dev"
    region = "us-west-2"
  }
}
