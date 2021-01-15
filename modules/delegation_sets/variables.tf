variable "create" {
  description = "Whether to create Route53 delegation sets"
  type        = bool
  default     = true
}

variable "delegation_sets" {
  description = "Map of Route53 delegation set parameters"
  type        = any
  default     = {}
}
