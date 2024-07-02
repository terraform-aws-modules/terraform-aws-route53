variable "create" {
  description = "Whether to create Route53 Zone associations"
  type        = bool
  default     = true
}

variable "zone_vpc_associations" {
  description = "Map of associations indicating zone_id and vpc_id to associate. The region is optional and will be derived from the provider if not passed."
  type        = map(object({
    zone_id    = string
    vpc_id     = string
    vpc_region = optional(string)
  }))
}
