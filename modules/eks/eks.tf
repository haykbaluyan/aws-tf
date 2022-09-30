module eks {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.6"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = local.vpc_id
  subnet_ids = local.subnet_ids

  cluster_endpoint_private_access   = true 
  enable_irsa                       = true

  cloudwatch_log_group_retention_in_days = 3

  # TODO: encryption key
  #cluster_encryption_config = [{
  #provider_key_arn = "arn:aws:kms:eu-west-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  #resources        = ["secrets"]
  #}

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
    aws-ebs-csi-driver = {
      resolve_conflicts = "OVERWRITE"
    }
  }
  
  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 0-65535"
      protocol                   = "tcp"
      from_port                  = 0
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
    ingress_allow_access_from_farge_to_efs = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 2049
      to_port                       = 2049
      source_cluster_security_group = true
      description                   = "Allow access EFS"
    }
    ingress_cluster_node_all = {
      description = "ingress_cluster_node_all"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      source_cluster_security_group = true
    }
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  eks_managed_node_group_defaults = {
    instance_types = var.eks_instance_types
    #ami_type = "AL2_x86_64"

    attach_cluster_primary_security_group = false

    # Disabling and using externally provided security groups
    # ALB works with a single SG
    create_security_group = false
  }

  eks_managed_node_groups = {
    default_node_group  = {
      name = "${local.cluster_name}-node-group-1"

      instance_types = var.eks_instance_types

      min_size     = 1
      max_size     = 6
      desired_size = 3

      additional_ebs_volumes = [local.ebs_block_device]

      pre_bootstrap_user_data = <<-EOT
      echo 'bootstrap started'
      EOT
    }
  }

  manage_aws_auth_configmap         = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::450692200673:user/hayk.baluyan"
      username = "hayk.baluyan"
      groups   = ["system:masters"]
    }
  ]
}