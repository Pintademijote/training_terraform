resource "aws_eip" "pg_eip" {
  vpc  = true
  tags = var.tag_ec2
}

resource "aws_eip_association" "eip_pg" {
  instance_id   = var.instance_id
  allocation_id = aws_eip.pg_eip.id

}