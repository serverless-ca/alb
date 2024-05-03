resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags
}

resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
}

resource "aws_subnet" "subnet_ingress_az1" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = var.subnet_ingress_cidr_az1

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-ingress-${var.az1}"
    },
  )
}

resource "aws_subnet" "subnet_ingress_az2" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az2
  cidr_block        = var.subnet_ingress_cidr_az2

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-ingress-${var.az2}"
    },
  )
}

resource "aws_subnet" "subnet_dmz_az1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az1
  cidr_block              = var.subnet_dmz_cidr_az1
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-dmz-${var.az1}"
    },
  )
}

resource "aws_subnet" "subnet_dmz_az2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az2
  cidr_block              = var.subnet_dmz_cidr_az2
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-dmz-${var.az2}"
    },
  )
}

resource "aws_subnet" "subnet_priv_az1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az1
  cidr_block              = var.subnet_priv_cidr_az1
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-private-${var.az1}"
    },
  )
}

resource "aws_subnet" "subnet_priv_az2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az2
  cidr_block              = var.subnet_priv_cidr_az2
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-private-${var.az2}"
    },
  )
}
