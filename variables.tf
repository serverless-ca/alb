variable "project" {
  description = "abbreviation for the project, forms first part of resource names"
  default     = "alb"
}

variable "alb_domain_name" {
  description = "Fully qualified domain name of ALB, e.g. hello.apps.example.com"
}

variable "hosted_zone_id" {
  description = "Hosted zone ID for public zone, e.g. Z0123456XXXXXXXXXXX"
}

variable "tags" {
  type        = map(string)
  description = "Optional Tags"
  default     = {}
}

variable "vpc_cidr" {
  description = "vpc CIDR range"
  default     = "172.16.0.0/16"
}

variable "subnet_ingress_cidr_az1" {
  description = "AZ1 Ingress subnet"
  default     = "172.16.3.0/24"
}
variable "subnet_ingress_cidr_az2" {
  description = "AZ2 Ingress subnet"
  default     = "172.16.130.0/24"
}

variable "subnet_dmz_cidr_az1" {
  description = "AZ1 DMZ subnet"
  default     = "172.16.1.0/24"
}
variable "subnet_dmz_cidr_az2" {
  description = "AZ2 DMZ subnet"
  default     = "172.16.128.0/24"
}

variable "subnet_priv_cidr_az1" {
  description = "AZ1 private subnet"
  default     = "172.16.2.0/24"
}

variable "subnet_priv_cidr_az2" {
  description = "AZ2 private subnet"
  default     = "172.16.129.0/24"
}

variable "instance_type" {
  default = "t3.micro"
}
