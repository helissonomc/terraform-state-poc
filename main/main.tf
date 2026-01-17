module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
}

module "igw" {
  source            = "./igw"
  public_subnet_ids = module.subnets.public_subnets[*].id
  vpc_id            = module.vpc.vpc_id
}

module "nat_gateway" {
  source             = "./nat_gateway"
  public_subnet_id   = module.subnets.public_subnets[0].id
  private_subnet_ids = module.subnets.private_subnets[*].id
  vpc_id             = module.vpc.vpc_id
}

module "security_groups" {
  source         = "./security_groups"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
}

# module "ec2" {
#   source            = "./ec2"
#   ami_id            = "ami-0c02fb55956c7d316" # Example Amazon Linux AMI
#   instance_type     = "t2.micro"
#   public_subnet_id  = module.subnets.public_subnets[0].id
#   security_group_id = module.security_groups.intra_vpc_sg_id
# }

# module "rds" {
#   source                = "./rds"
#   private_subnet_ids    = module.subnets.private_subnets[*].id
#   vpc_security_group_id = module.security_groups.rds_sg_id
#   db_name               = "mydatabase"
#   username              = "postgis"
#   password              = "password123"
# }


