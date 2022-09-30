variable cluster_version {
  description = "Version of k8 cluster"
  type        = string
}

variable ami_id {
  type        = string
  description = "AMI id" 
  default     = "ami-0cea098ed2ac54925"
}

variable eks_instance_types{
  default = ["t3.medium"]
}

variable kms {
  type = map(any)
}

variable remote_state_vpc {
  type = map(any)
}