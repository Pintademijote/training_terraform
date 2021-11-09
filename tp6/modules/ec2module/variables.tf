variable "prenom" {
  type    = string
  default = "pg"
}

variable "tag_ec2" {
  type = map(any)
  default = {
    Name      = "ec2-pg"
    Formation = "ajc"
  }
}

variable "taille_ec2" {
  default = "t2.nano"
}

variable "sg_name" {
  default = "pg_sg"
}

variable "keyname_type" {
  default = "dev"
}

variable "path_key_ssh" {
  type    = string
  default = "/home/vagrant/devops-pg.pem"
}