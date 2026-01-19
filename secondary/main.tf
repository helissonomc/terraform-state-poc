# Find the RDS security group that exists in AWS
data "aws_security_group" "rds" {
  filter {
    name   = "tag:Name"
    values = ["rds-sg"]
  }
}

# Find private subnets that exist in AWS
data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-*"]
  }
}

module "rds" {
  source                = "./rds"
  private_subnet_ids    = data.aws_subnets.private.ids
  vpc_security_group_id = data.aws_security_group.rds.id
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password
}

# Outputs to verify data sources are fetching correct resources
output "fetched_rds_security_group" {
  description = "Security group fetched from AWS"
  value = {
    id   = data.aws_security_group.rds.id
    name = data.aws_security_group.rds.name
    tags = data.aws_security_group.rds.tags
  }
}

output "fetched_private_subnet_ids" {
  description = "Private subnet IDs fetched from AWS"
  value       = data.aws_subnets.private.ids
}
