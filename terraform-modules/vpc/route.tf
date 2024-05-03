resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_main.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-dmz"
    },
  )
}

resource "aws_route_table_association" "dmz_az1" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.subnet_dmz_az1.id
}

resource "aws_route_table_association" "dmz_az2" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.subnet_dmz_az2.id
}

resource "aws_route_table_association" "ingress_az1" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.subnet_ingress_az1.id
}

resource "aws_route_table_association" "ingress_az2" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.subnet_ingress_az2.id
}

resource "aws_route_table" "rtb_pvt_az1" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-private-${var.az1}"
    },
  )
}

resource "aws_route" "route_nat_az1" {
  route_table_id         = aws_route_table.rtb_pvt_az1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_az1.id
}

resource "aws_route_table_association" "rtb_dmz_to_priv_az1" {

  route_table_id = aws_route_table.rtb_pvt_az1.id
  subnet_id      = aws_subnet.subnet_priv_az1.id
}

resource "aws_route_table" "rtb_pvt_az2" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-private-${var.az2}"
    },
  )
}

resource "aws_route" "route_nat_az2" {
  route_table_id         = aws_route_table.rtb_pvt_az2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_az2.id
}

resource "aws_route_table_association" "rtb_dmz_to_priv_az2" {

  route_table_id = aws_route_table.rtb_pvt_az2.id
  subnet_id      = aws_subnet.subnet_priv_az2.id
}