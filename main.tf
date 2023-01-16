provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr         = ["10.0.0.0/16","10.1.0.0/16","10.2.0.0/16"]
  availability_zone = ["us-east-1a", "us-east-1b"]
}