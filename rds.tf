resource "aws_db_subnet_group" "subnet_group-rds" {
  name       = "dimo-qa-rds-subent-group"
  subnet_ids = [module.network.db-1, module.network.db-2]

  tags = {
    Name = "dimo-qa-rds-subent-group"
  }
}

# output "db_subnet_group_name" {
#   description = "The name of the RDS DB subnet group"
#   value       = aws_db_subnet_group.subnet_group-rds.name
# }

module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "dimo-qa-pvt-rds"

  engine               = "mysql"
  major_engine_version = "8.0"
  engine_version       = "8.0.41"
  family               = "mysql8.0"
  instance_class       = "db.m5.large"
  allocated_storage    = 50
  #max_allocated_storage = 1000  # need to define this to enable storage autoscalling

  storage_type = "gp3"

  #db_name = "proddb"
  #parameter_group_name = "default.mysql8.0"
  create_db_parameter_group   = false
  manage_master_user_password = true
  username                    = "admin"
  #password                    = "admin123"
  port = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.security.db-sg]

  # maintenance and backup
  #timezone           = "GMT Standard Time"
  maintenance_window = "Sun:03:00-Sun:06:00"
  backup_window      = "06:30-09:30"
  apply_immediately  = true


  # db subnet group
  db_subnet_group_name = aws_db_subnet_group.subnet_group-rds.name
  multi_az             = false


  deletion_protection = true
  skip_final_snapshot = false

  tags = {
    Name = "dimo-qa-pvt-rds"
    #Backup = "true"
  }

  depends_on = [
    aws_db_subnet_group.subnet_group-rds
  ]

}
