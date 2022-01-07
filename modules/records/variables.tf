variable "create" {
  description = "Whether to create DNS records"
  type        = bool
  default     = true
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
  description = "List of maps of DNS records"
  type        = any
  default     = []
}

variable "records_json" {
  description = "JSON encoded list of maps of DNS records"
  type        = string
  default     = null
}

variable "record_map_keys" {
  description = "List of custom map keys for the internal map. Must have the same length as the records or records_json variable. May contain null values and the module will generate the key itself"
  type        = list(string)
  default     = []
}
