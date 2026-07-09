
resource "aws_iam_role" "ec2_ssm_role" {
  name = "dimo-qa-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ssm_core_attach" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "dimo-qa-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}


resource "aws_instance" "ec2_instance" {
  ami                    = var.ami           # change
  instance_type          = var.instance-type # change 
  subnet_id              = var.pvt-sub1
  vpc_security_group_ids = [var.vpc-sg]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name


  root_block_device {
    volume_size = 100
    volume_type = "gp3"
    encrypted   = true
  }



  tags = {
    Name = var.instance-name
  }
}
