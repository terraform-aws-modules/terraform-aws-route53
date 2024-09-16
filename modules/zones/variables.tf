variable "create" {
  description = "Whether to create Route53 zone"
  type        = bool
  default     = true
}

variable "zones" {
  description = "Map of Route53 zone parameters"
  type = map(object({
    domain_name       = optional(string)
    comment           = optional(string)
    force_destroy     = optional(bool)
    delegation_set_id = optional(string)
    vpc = optional(list(object({
      vpc_id     = string
      vpc_region = optional(string)
    })))
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "tags" {
  description = "Tags added to all zones. Will take precedence over tags from the 'zones' variable"
  type        = map(string)
  default     = {}
}
