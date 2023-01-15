variable "fqdn" {
  type        = string
  default     = ""
  description = "The fully qualified domain name to generate a certificate for"
}

variable "hosted_zone_id" {
  type        = string
  default     = ""
  description = "Route53 Hosted Zone ID"
}
