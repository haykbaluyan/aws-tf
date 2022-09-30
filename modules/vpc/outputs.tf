output shared {
  value = {
    environment  = var.environment
    region       = var.region
    account_id   = data.aws_caller_identity.current.account_id
    vpc_name     = module.vpc.name
    cluster_name = local.cluster_name
  }
}

output vpc_subnets {
  value = var.vpc_subnets
}

output vpc_info {
  value = {
    vpc_id              = module.vpc.vpc_id
    name                = module.vpc.name
    azs                 = module.vpc.azs
    intra_subnets       = module.vpc.intra_subnets
    private_subnets     = module.vpc.private_subnets
    public_subnets      = module.vpc.public_subnets
    nat_public_ips      = module.vpc.nat_public_ips
    default_sg          = module.vpc.default_security_group_id
    
    default_route_table_id  = module.vpc.default_route_table_id
    intra_route_table_ids   = module.vpc.intra_route_table_ids
    private_route_table_ids = module.vpc.private_route_table_ids
  }
}

output eips {
  value = aws_eip.nat[*].public_ip
}