provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
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
  icybox_cert_arn         = module.r53.icybox_cert_arn
}

module "sg" {
  source         = "../../modules/sg"
  naming_prefix  = local.naming_prefix
  vpc_id         = module.network.vpc_id
  vpc_cidr_block = module.network.vpc_cidr_block
}

module "asg" {
  source        = "../../modules/asg"
  naming_prefix = local.naming_prefix
  alb_tg_arn    = module.alb.alb_tg_arn
  subnets       = module.network.subnets
  ec2_sg        = [module.sg.ec2_sg_id]
}

module "r53" {
  source        = "../../modules/r53"
  naming_prefix = local.naming_prefix
  domain        = var.domain
  alb_dns       = module.alb.aws_alb_dns
  alb_zone_id   = module.alb.aws_alb_zone_id
}

module "lambda" {
  source        = "../../modules/lambda"
  naming_prefix = local.naming_prefix
  subnets       = module.network.subnets
  ec2_sg        = [module.sg.ec2_sg_id]
}