terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "terraform.eks.remote.state"
    key            = "terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "terraform_state_locks"
  }
}