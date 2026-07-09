output "vpc-id" {

  description = "vpc id"
  value       = aws_vpc.main-vpc.id
}

output "pvt-1" {

  description = "pvt-1"
  value       = aws_subnet.pvt-1.id
}

output "pub-1" {

  description = "pub-1"
  value       = aws_subnet.pub-1.id
}

output "pub-2" {

  description = "pub-2"
  value       = aws_subnet.pub-2.id
}

output "db-1" {

  description = "db-1"
  value       = aws_subnet.db-1.id
}

output "db-2" {

  description = "db-2"
  value       = aws_subnet.db-2.id
}



