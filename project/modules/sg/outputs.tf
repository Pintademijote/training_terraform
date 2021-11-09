output "sgname" {
  description = "Name of the sg"
  value       = aws_security_group.pg_sg.name
}