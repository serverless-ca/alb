variable "project" {
  description = "The name of the project"
}

variable "tags" {
  description = "Optional tags"
}

variable "zone_id" {
  description = "Hosted zone ID for base domain"
}

variable "domain_name" {
  description = "Fully qualified domain name without a period at the end"
}

variable "certificate_transparency" {
  description = "Whether certificate details should be added to public certificate transparency log"
  default     = "ENABLED"
}

variable "validation_method" {
  description = "Certificate validation method"
  default     = "DNS"
}