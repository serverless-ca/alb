variable "project" {
  description = "The name of the project"
}

variable "tags" {
  description = "Optional tags"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate to use for HTTPS"
}

variable "zone_id" {
  description = "Hosted zone ID for base domain"
}

variable "domain_name" {
  description = "Fully qualified domain name without a period at the end"
}

variable "asg_name" {
  description = "Name of autoscaling group"
}

variable "subnet_ingress_az1_id" {
  description = "VPC subnet used by private compute instance in AZ1"
}

variable "subnet_ingress_az2_id" {
  description = "VPC subnet used by private compute instance in AZ2"
}