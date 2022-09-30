
output shared {
  value = module.vpc.shared
}

output vpc_subnets {
  value = module.vpc.vpc_subnets
}

output vpc {
  value = module.vpc.vpc_info
}

output eips {
  value = module.vpc.eips
}

output remote_state {
  value = {
    bucket = "hb-test-terraform"
    key    = "dev/hb-test-vpc-dev"
    region = "us-west-2"
  }
}