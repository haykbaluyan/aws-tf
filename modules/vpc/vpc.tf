resource aws_eip nat {
  count = var.vpc_eip_count

  vpc = true
}

module vpc {
  source = "terraform-aws-modules/vpc/aws"

  name = local.cluster_name
  cidr = var.vpc_cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)
  
  private_subnets     = var.vpc_subnets.private
  public_subnets      = var.vpc_subnets.public
  intra_subnets       = var.vpc_subnets.intra

  enable_vpn_gateway   = false
  enable_nat_gateway   = true

  # Determines whether the VPC supports assigning public DNS hostnames to instances with public IP addresses.
  # The default for this attribute is false unless the VPC is a default VPC.
  enable_dns_hostnames = true

  # Determines whether the VPC supports DNS resolution through the Amazon provided DNS server.
  # If this attribute is true, queries to the Amazon provided DNS server succeed. 
  enable_dns_support   = true

  single_nat_gateway   = var.vpc_eip_count == 1
  reuse_nat_ips        = true                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids  = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }

  tags = local.tags
}

#
# allow access to S3 from Private 
#

resource aws_vpc_endpoint s3_vpc_endpoint {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
  
  tags = local.tags
}

resource aws_vpc_endpoint_route_table_association s3_vpc_0 {
  # TODO: counter, as Prod will have more NAT
  route_table_id  = module.vpc.private_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.s3_vpc_endpoint.id
}

#
# ECR
#
resource aws_vpc_endpoint ecr_dkr_vpc_endpoint {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  tags = local.tags
}

resource aws_vpc_endpoint ecr_api_vpc_endpoint {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"

  tags = local.tags
}