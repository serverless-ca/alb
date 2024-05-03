module "acm" {
  source      = "./terraform-modules/acm"
  domain_name = var.alb_domain_name
  zone_id     = var.hosted_zone_id
  project     = var.project
  tags        = var.tags
}

module "alb" {
  source                = "./terraform-modules/alb"
  project               = var.project
  tags                  = var.tags
  vpc_id                = module.vpc.vpc_id
  domain_name           = var.alb_domain_name
  zone_id               = var.hosted_zone_id
  certificate_arn       = module.acm.certificate_arn
  asg_name              = module.ec2.asg_name
  subnet_ingress_az1_id = module.vpc.subnet_ingress_az1_id
  subnet_ingress_az2_id = module.vpc.subnet_ingress_az2_id
}

module "vpc" {
  source                  = "./terraform-modules/vpc"
  project                 = var.project
  tags                    = var.tags
  vpc_cidr                = var.vpc_cidr
  az1                     = data.aws_availability_zones.available.names[0]
  az2                     = data.aws_availability_zones.available.names[1]
  subnet_ingress_cidr_az1 = var.subnet_ingress_cidr_az1
  subnet_ingress_cidr_az2 = var.subnet_ingress_cidr_az2
  subnet_dmz_cidr_az1     = var.subnet_dmz_cidr_az1
  subnet_dmz_cidr_az2     = var.subnet_dmz_cidr_az2
  subnet_priv_cidr_az1    = var.subnet_priv_cidr_az1
  subnet_priv_cidr_az2    = var.subnet_priv_cidr_az2
}

module "ec2" {
  source             = "./terraform-modules/ec2"
  project            = var.project
  tags               = var.tags
  image              = data.aws_ami.amazon_linux_2023.id
  instance_type      = var.instance_type
  vpc_id             = module.vpc.vpc_id
  subnet_priv_az1_id = module.vpc.subnet_priv_az1_id
  subnet_priv_az2_id = module.vpc.subnet_priv_az2_id
  alb_sg_id          = module.alb.alb_sg_id
}