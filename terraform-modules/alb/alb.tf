resource "aws_lb" "app" {
  name               = "${var.project}-${local.env}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.subnet_ingress_az1_id, var.subnet_ingress_az2_id]

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  security_groups                  = [aws_security_group.lb_access_sg.id]

  tags = local.tags
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_lb_listener" "http_https_redirect" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "app" {
  name     = "${var.project}-${local.env}-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    interval            = 10
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  depends_on = [aws_lb.app]
}

resource "aws_autoscaling_attachment" "app" {
  autoscaling_group_name = var.asg_name
  lb_target_group_arn    = aws_lb_target_group.app.arn
}

resource "aws_security_group" "lb_access_sg" {
  name        = "${var.project}-${local.env}-alb-access-sg"
  description = "Controls access to the Load Balancer"
  vpc_id      = var.vpc_id

  tags = merge(
    local.tags,
    {
      Name = "${var.project}-${local.env}-alb-access-sg"
    },
  )
}

resource "aws_security_group_rule" "http_ingress" {
  security_group_id = aws_security_group.lb_access_sg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"

  description = "HTTP ingress for LB"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_ingress" {
  security_group_id = aws_security_group.lb_access_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"

  description = "HTTPS ingress for LB"

  cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "http_egress" {
  security_group_id = aws_security_group.lb_access_sg.id
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"

  description = "HTTP access to app"

  cidr_blocks = ["0.0.0.0/0"]
}
