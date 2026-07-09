# Application Load Balancer  
resource "aws_lb" "main" {
  name               = var.alb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb-sg]
  subnets            = [var.pub-1, var.pub-2]

  enable_deletion_protection = false

}

# Target Group for smartgrid 8080  
resource "aws_lb_target_group" "qa-ec2_80" {
  name        = "dimo-qa-ec2-80-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc-id
  target_type = "instance"

  # health_check {  
  #   enabled             = true  
  #   healthy_threshold   = 2  
  #   interval            = 60  
  #   matcher            = "200"  
  #   path               = "/"  # adjust based on health check endpoint  
  #   port               = 8090
  #   protocol           = "HTTP"  
  #   timeout            = 20  
  #   unhealthy_threshold = 5  
  # }  

}
