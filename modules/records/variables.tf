variable "create" {
  description = "Whether to create DNS records"
  type        = bool
  default     = true
}

variable "skip_zone_lookup" {
  description = "Whether to skip zone lookup.  If set to true, zone_id and zone_name must be provided"
  type        = bool
  default     = false
}

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

variable "records" {
  description = "List of objects of DNS records"
  type        = any
  default     = []
}

variable "records_jsonencoded" {
  description = "List of map of DNS records (stored as jsonencoded string, for terragrunt)"
  type        = string
  default     = null
}
