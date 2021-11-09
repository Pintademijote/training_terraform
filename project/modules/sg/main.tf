locals {
  ports_in = var.list_ports
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