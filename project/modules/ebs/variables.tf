variable "size_ebs" {
  type    = number
  default = 10
}

variable "tag_ec2" {
  type = map(any)
  default = {
    Name      = "ec2-pg"
    Formation = "ajc"
  }
}

variable "instance_id" {
  default = module.ec2.instance_id
}