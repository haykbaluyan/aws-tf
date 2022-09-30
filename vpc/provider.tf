# This is the remote state. The bucket has versioning enabled.
terraform {
  backend s3 {
    bucket = "hb-test-terraform"
    key    = "dev/hb-test-vpc-dev"
    region = "us-west-2"
  }
}
