terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

 resource "aws_instance" "pg_centos7_t2micro" {
   ami           = "ami-0057d8e6fb0692b80"
   instance_type = "t2.micro"

   tags = {
       Name = "pg"
       Formation = "ajc"
   }

   root_block_device {
       delete_on_termination = true
   }
 }