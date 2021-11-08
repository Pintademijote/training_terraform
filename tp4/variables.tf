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