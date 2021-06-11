
variable name {
  description = "Zone name"
  type        = string
}

variable comment {
  description = "Comment"
  type        = string
  default     = null
}

variable force_destroy {
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone"
  type        = bool
  default     = false
}

variable vpc  {
  description = "VPC(s) to associate with a private hosted zone"
  type        = any
  default = []
}

variable records {
  description = "List of Route53 records"
  type        = any
  default = []
}

variable "tags" {
  description = "Tags added to zone"
  type        = map(string)
  default     = {}
}

# If neither parent_id not parent_name are set, NS records
# for this zone won't be created.

variable parent_id {
  description = "ID of zone where NS records for this zone will be created"
  type = string
  default = null
}

variable parent_name {
  description = "Name of zone where NS records for this zone will be created. 'auto' means remove substring up to 1st dot from current zone name"
  type = string
  default = null
}

variable parent_is_private {
  description = "Wheter parent zone is a private zone"
  type = bool
  default = false
}

variable ns_ttl {
  description = "TTL for NS records"
  type = number
  default = 300
}
