provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/Users/amenezes/.aws/credentials"
  profile                 = "default"
}

data "aws_availability_zones" "available" {}