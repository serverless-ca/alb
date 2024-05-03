resource "aws_security_group" "compute" {
  name   = "${var.project}-${local.env}-compute"
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-compute"
    },
  )
}

resource "aws_security_group_rule" "egress_https" {
  security_group_id = aws_security_group.compute.id

  type        = "egress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_icmp" {
  security_group_id = aws_security_group.compute.id

  type        = "egress"
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_http" {
  security_group_id = aws_security_group.compute.id

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.alb_sg_id
}
