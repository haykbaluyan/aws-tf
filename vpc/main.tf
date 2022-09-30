module vpc {
    source = "../modules/vpc"
    
    region        = "us-west-2"
    environment   = "dev"
    vpc_name      = "hb-test"
    vpc_cidr      = "10.0.0.0/16"
    vpc_eip_count = 1

    vpc_subnets={
        public      = ["10.0.101.0/26","10.0.102.0/26","10.0.103.0/26"]
        private     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]   
        intra       = ["10.0.51.0/24", "10.0.52.0/24", "10.0.53.0/24"]
    }
}
