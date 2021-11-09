locals {
  ports_in = [
    22,
    443,
    80
  ]
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

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
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = var.taille_ec2
  key_name        = var.keyname_type
  security_groups = [aws_security_group.pg_sg.name]

  tags = var.tag_ec2

  root_block_device {
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1",
      "sudo systemctl enabled nginx",
      "sudo systemctl start nginx"
    ]

  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > infos_ec2.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.path_key_ssh)
    host        = self.public_ip
  }

}

resource "aws_eip" "pg_eip" {
  vpc  = true
  tags = var.tag_ec2
}

resource "aws_eip_association" "eip_pg" {
  instance_id   = aws_instance.pg_t2.id
  allocation_id = aws_eip.pg_eip.id

}

resource "aws_security_group" "pg_sg" {
  name = var.sg_name
  dynamic "ingress" {
    for_each = toset(local.ports_in)
    content {
      description = "HTTPS from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

terraform {

}
# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   security_group_id    = aws_security_group.pg_sg.id
#   network_interface_id = aws_instance.pg_t2.primary_network_interface_id
# }

