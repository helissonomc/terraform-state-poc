resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group-new"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "db-subnet-group-new"
  }
}

resource "aws_db_parameter_group" "postgres_logical_replication" {
  name   = "postgres-logical-replication"
  family = "postgres16"

  parameter {
    name  = "rds.logical_replication" # This is a static parameter that requires a reboot, blue / green deployment requires it to be set here
    value = "1"
    apply_method = "pending-reboot"
  }

  tags = {
    Name = "postgres-logical-replication"
  }
}

resource "aws_db_parameter_group" "postgres_logical_replication18" {
  name   = "postgres-logical-replication18"
  family = "postgres18"

  parameter {
    name  = "rds.logical_replication" # This is a static parameter that requires a reboot, blue / green deployment requires it to be set here
    value = "1"
    apply_method = "pending-reboot"
  }

  tags = {
    Name = "postgres-logical-replication"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  publicly_accessible    = false
  vpc_security_group_ids = [var.vpc_security_group_id]
  skip_final_snapshot    = var.skip_final_snapshot
  allow_major_version_upgrade = true
  parameter_group_name        = aws_db_parameter_group.postgres_logical_replication18.name
  backup_retention_period = 1
  backup_window          = "09:00-10:00"
  apply_immediately           = true  # Required for static parameter changes

  blue_green_update {
    enabled = true
  }

  tags = {
    Name = "rds-instance"
  }
}

