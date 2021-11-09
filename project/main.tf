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
  security_group_name = module.sg.sgname
}

module "ebs" {
  source = "./modules/ebs"
  instance_id = module.ec2.instance_id
}

module "eip" {
  source = "./modules/eip"
  instance_id = module.ec2.instance_id
}

module "sg" {
  source = "./modules/sg"
}