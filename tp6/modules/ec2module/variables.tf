variable "prenom" {
  type        = string
  default     = "pg"
}

variable "tag_ec2" {
  type        = map
  default     = {
    Name = "ec2-pg"
    Formation = "ajc"
   }
}

variable "taille_ec2" {
  default = "t2.nano"
}

variable "sg_name" {
  default = "pg_sg"
}