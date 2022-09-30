module deploy-eks {
    source = "../modules/eks"
    
    cluster_version = "1.23"
    
    eks_instance_types = ["t3.medium"]

    kms = {
        kubeca_key = "arn:aws:kms:us-west-2:450692200673:key/4f5664cb-80c7-474a-ba6d-16eba635a078"
    }

    remote_state_vpc = {
        bucket = "hb-test-terraform"
        key    = "dev/hb-test-vpc-dev"
        region = "us-west-2"
    }
}