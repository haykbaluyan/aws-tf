locals {
  # to help ensure generated IDs are globally unique
  namespace      = "${var.vpc_name}-${var.environment}"
  cluster_name   = "${var.vpc_name}-${var.environment}"

  account_id = data.aws_caller_identity.current.account_id

  // Tags
  tags = {
    Terraform   = "true"
    Environment = var.environment
    VPC         = local.cluster_name
  }
}
