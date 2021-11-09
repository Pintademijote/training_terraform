variable "list_ports" {
  type = list(number)
  default = [22, 80, 443]
}

variable "sg_name" {
  default = "pg_sg"
}

