resource "aws_eip" "eip_az1" {
  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-nat-az1"
    },
  )
}

resource "aws_eip" "eip_az2" {
  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-nat-az2"
    },
  )
}


resource "aws_nat_gateway" "natgw_az1" {
  allocation_id = aws_eip.eip_az1.id
  subnet_id     = aws_subnet.subnet_dmz_az1.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-${var.az1}"
    },
  )

}

resource "aws_nat_gateway" "natgw_az2" {
  allocation_id = aws_eip.eip_az2.id
  subnet_id     = aws_subnet.subnet_dmz_az2.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-${var.az2}"
    },
  )
}
