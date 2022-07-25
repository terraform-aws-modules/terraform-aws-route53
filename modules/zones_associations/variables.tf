variable "create" {
  description = "Whether to create Route53 zone"
  type        = bool
  default     = true
}

variable "zones_associations" {
  description = "List of map of Route53 zone association parameters"
  type        = list(map(any))
  default     = []
}
