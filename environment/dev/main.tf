provider "aws" {
  region = "us-east-1"
}

module "network" {
  source        = "../../modules/network"
  naming_prefix = local.naming_prefix
}

module "alb" {
  source                  = "../../modules/alb"
  naming_prefix           = local.naming_prefix
  vpc_id                  = module.network.vpc_id
  subnets                 = module.network.subnets
  vpc_public_subnet_count = module.network.vpc_public_subnet_count
  alb_sg                  = [module.sg.alb_sg_id]
  ec2_sg                  = [module.sg.ec2_sg_id]
}

module "sg" {
  source         = "../../modules/sg"
  naming_prefix  = local.naming_prefix
  vpc_id         = module.network.vpc_id
  vpc_cidr_block = module.network.vpc_cidr_block
}