terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

locals {
  ports_in = [
    22,
    443,
    80
  ]
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["amazon"]

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

 resource "aws_instance" "pg_t2" {
   ami           = "${data.aws_ami.amazon-linux-2.id}"
   instance_type = "t2.micro"
   key_name = "devops-pg"
   security_groups = [ aws_security_group.pg_sg.name ]

   tags = var.tag_ec2

   root_block_device {
       delete_on_termination = true
   }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y nginx"
    ]
  
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > infos_ec2.txt"
  }

  connection {
    type="ssh"
    user="ec2-user"
    private_key=file("/home/vagrant/devops-pg.pem")
    host=self.public_ip
  }

 }

 resource "aws_eip" "pg_eip" {
   vpc = true
   tags = var.tag_ec2
 }

 resource "aws_eip_association" "eip_pg" {
   instance_id = aws_instance.pg_t2.id
   allocation_id = aws_eip.pg_eip.id

 }

 resource "aws_security_group" "pg_sg" {
  name        = "pg_sg"
  dynamic "ingress" {
    for_each = toset(local.ports_in)
    content {
      description      = "HTTPS from VPC"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  }


}

# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   security_group_id    = aws_security_group.pg_sg.id
#   network_interface_id = aws_instance.pg_t2.primary_network_interface_id
# }

