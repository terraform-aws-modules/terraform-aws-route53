variable "create" {
  description = "Whether to create Route53 Resolver rule associations"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "Default VPC ID for all the Route53 Resolver rule associations"
  type        = string
  default     = null
}

variable "resolver_rule_associations" {
  description = "Map of Route53 Resolver rule associations parameters"
  type        = any
  default     = {}
}
