locals {

  environment  = data.terraform_remote_state.vpc.outputs.shared.environment
  region       = data.terraform_remote_state.vpc.outputs.shared.region
  cluster_name = data.terraform_remote_state.vpc.outputs.shared.cluster_name
  cluster_id   = data.terraform_remote_state.vpc.outputs.shared.cluster_name
  account_id   = data.aws_caller_identity.current.account_id
  
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc.vpc_id
  subnet_ids            = data.terraform_remote_state.vpc.outputs.vpc.private_subnets
  vpc_private_route_ids = data.terraform_remote_state.vpc.outputs.vpc.private_route_table_ids
  vpc_private_subnets   = data.terraform_remote_state.vpc.outputs.vpc.private_subnets

  kubeca_namespace = "kubeca"
  hb_namespace  = "hb"
  jobs_namespace   = "hb-jobs"

  tags = {
    Terraform   = "true"
    Environment = data.terraform_remote_state.vpc.outputs.shared.environment
    Cluster     = data.terraform_remote_state.vpc.outputs.shared.cluster_name
  }

  ebs_block_device = {
    block_device_name = "/dev/sdc",
    volume_type = "gp2"
    volume_size = 10
  }
}
