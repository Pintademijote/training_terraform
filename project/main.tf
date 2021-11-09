terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "terraform-backend-pg"
    key    = "tfstate/state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source = "./modules/ec2"
}

module "ebs" {
  source = "./modules/ebs"
}

module "eip" {
  source = "./modules/eip"
}

module "sg" {
  source = "./modules/sg"
}