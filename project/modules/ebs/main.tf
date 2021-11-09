resource "aws_ebs_volume" "pg_ebs" {
  availability_zone = "us-east-1a"
  size              = var.size_ebs

  tags = var.tag_ec2
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.pg_ebs.id
  instance_id = var.instance_id
}