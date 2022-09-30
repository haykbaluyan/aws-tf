data aws_caller_identity current {}

data terraform_remote_state vpc {
  backend = "s3"
  config = var.remote_state_vpc
}