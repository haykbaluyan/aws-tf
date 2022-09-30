variable environment {
  description = "Name of the environment: dev|stage|prod"
  type        = string
}

variable region {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable vpc_name {
  description = "VPC name"
  type        = string
  default     = "hb"
}

variable vpc_eip_count {
  description = "Number of EIP"
  type        = number
  default     = 1
}

variable vpc_cidr {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable vpc_subnets {
  type = map(any)
  default = {
    public      = ["10.0.101.0/26","10.0.102.0/26","10.0.103.0/26"]
    private     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]    
    intra       = ["10.0.51.0/24", "10.0.52.0/24", "10.0.53.0/24"]  
  }
  description = "VPC subnets: {public,private,intra}"
  # CIDR	Subnet mask	    # of usable IP addresses
  #  /26	255.255.255.192	  62
  #  /25	255.255.255.128	  126
  #  /24	255.255.255.0	    254
  #  /23	255.255.254.0	    510
}