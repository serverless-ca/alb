variable "project" {
  description = "The name of the project"
}

variable "tags" {
  description = "Optional tags"
}

variable "image" {
  description = "Image AMI"
}

variable "instance_type" {
  description = "virtual machine size"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_priv_az1_id" {
  description = "VPC subnet used by private compute instance in AZ1"
}

variable "subnet_priv_az2_id" {
  description = "VPC subnet used by private compute instance in AZ2"
}

variable "alb_sg_id" {
  description = "Security Group ID for ALB"
}
