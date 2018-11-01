# To enable locking via dynamodb use these instuctions:
# https://github.com/hashicorp/terraform/issues/12877#issuecomment-311649591
terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket"
    region  = "eu-west-1"
    profile = "default"

    # due to this bug: https://github.com/hashicorp/terraform/issues/13589
    # You need to either define the profile name in your bash env or name it default
  }
}
