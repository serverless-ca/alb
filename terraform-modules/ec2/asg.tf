resource "aws_launch_configuration" "compute" {
  name_prefix          = "${var.project}-${local.env}-compute"
  image_id             = var.image
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm.id
  security_groups      = [aws_security_group.compute.id]
  user_data            = file("${path.module}/user-data-apache")

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "compute" {
  name                      = "${var.project}-${local.env}-compute"
  launch_configuration      = aws_launch_configuration.compute.name
  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier       = [var.subnet_priv_az1_id, var.subnet_priv_az2_id]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  termination_policies      = ["OldestInstance"]

  tag {
    key                 = "Name"
    value               = "${var.project}-${local.env}-compute"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = local.env
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project
    propagate_at_launch = true
  }
  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
}
