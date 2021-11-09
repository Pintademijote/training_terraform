data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "pg_t2" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.taille_ec2
  key_name        = var.keyname_type
  security_groups = [var.security_group_name]

  tags = var.tag_ec2

  root_block_device {
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install -y nginx",
      "sudo ufw allow 'Nginx HTTP'",
      "sudo systemctl enabled nginx",
      "sudo systemctl start nginx"
    ]

  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.path_key_ssh)
    host        = self.public_ip
  }

}