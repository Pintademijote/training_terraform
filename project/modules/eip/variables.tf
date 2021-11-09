variable "tag_ec2" {
  type = map(any)
  default = {
    Name      = "ec2-pg"
    Formation = "ajc"
  }
}

variable "instance_id" {
  default = ""
}