output "alb-sg" {

  description = "alb security group"
  value       = aws_security_group.alb-sg.id
}


output "pvt-id" {

  description = "private security group"
  value       = aws_security_group.private-sg.id
}

output "db-sg" {

  description = "db security group"
  value       = aws_security_group.db-sg.id
}
