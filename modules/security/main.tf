
################### public security group ###########################

resource "aws_security_group" "alb-sg" {
  name        = "dimo-qa-pub_alb-sg"
  description = "public alb secuirty group"
  vpc_id      = var.vpc-id

  ingress {
    description = "TLS from VP HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # tags = {
  #   Name = "allow_tls"
  # }
}


################### private security group ###########################


resource "aws_security_group" "private-sg" {
  name        = "dimo-qa-pvt_ec2-sg"
  description = "private secuirty group"
  vpc_id      = var.vpc-id

  ingress {
    description     = "TLS from alb"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  ingress {
    description     = "TLS from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


################### db security group ###########################

resource "aws_security_group" "db-sg" {
  name        = "dimo-qa-db-sg"
  description = "db secuirty group"
  vpc_id      = var.vpc-id

  ingress {
    description     = "TLS from ec2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private-sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
