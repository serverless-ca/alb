resource "aws_flow_log" "vpc" {
  log_destination = aws_cloudwatch_log_group.vpc-flowlog-group.arn
  iam_role_arn    = aws_iam_role.flowlog-role.arn
  vpc_id          = aws_vpc.vpc.id
  traffic_type    = "ALL"

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-dmz-${var.az1}"
    },
  )
}

resource "aws_cloudwatch_log_group" "vpc-flowlog-group" {
  name              = "/${var.project}-${local.env}/${aws_vpc.vpc.id}/flowlog"
  retention_in_days = var.flow_log_retention_in_days
}

resource "aws_iam_role" "flowlog-role" {
  name = "${var.project}-${local.env}-flowlog-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = local.tags
}

resource "aws_iam_role_policy" "flowlogs-policy" {
  name = "${var.project}-${local.env}-flowlogs-policy"
  role = aws_iam_role.flowlog-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
