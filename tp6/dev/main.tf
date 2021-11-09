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

module "ec2module" {
  source = "../modules/ec2module"

  taille_ec2 = "t2.nano"
  tag_ec2 = {
    Name      = "ec2-dev-pg"
    Formation = "ajc"
  }
  sg_name      = "pg_sg_dev"
  keyname_type = "devops-pg"
}