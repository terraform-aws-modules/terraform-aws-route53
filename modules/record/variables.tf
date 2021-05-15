# At least one of zone_id/zone_name must be set

variable "zone_id" {
  description = "ID of DNS zone"
  type        = string
  default     = null
}

variable "zone_name" {
  description = "Name of DNS zone"
  type        = string
  default     = null
}

variable "private_zone" {
  description = "Whether Route53 zone is private or public"
  type        = bool
  default     = false
}

variable name {
  description = "Record name (without domain part, can be empty)"
  type        = string
}

variable type {
  description = "Record type"
  type        = string
}

variable ttl {
  description = "Record TTL"
  type        = number
  default     = 300
}

variable records {
  description = "Record value(s)"
  type        = any
}

variable alias {
  description = "Alias parameters (name, [zone_id], [evaluate_target_health])"
  type        = any
  default     = null
}

variable set_identifier {
  description = ""
  type        = string
  default     = ""
}

variable health_check_id {
  description = "The health check the record should be associated with"
  type        = any
  default     = null
}

variable failover_routing_policy {
  description = "Optional"
  type        = any
  default     = null
}

variable weighted_routing_policy {
  description = "Optional"
  type        = any
  default     = null
}
