variable "create" {
  description = "Whether to create Route53 zone"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags added to all zones. Will take precedence over tags from the 'zones' variable"
  type        = map(string)
  default     = {}
}

################################################################################
# Zone
################################################################################

variable "create_zone" {
  description = "Determines whether to create the Route53 zone or lookup an existing zone"
  type        = bool
  default     = true
}

variable "ignore_vpc" {
  description = "Determines whether to ignore VPC association changes after creation to avoid disruptive diffs when using `aws_route53_zone_association` resource(s). Changing is a destructive action; users should be prepared to use Terraform state move commands/blocks when changing this value"
  type        = bool
  default     = false
}

variable "private_zone" {
  description = "Whether the hosted zone is private. Only applicable when `create_zone = false`"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The ID of the VPC associated with the existing hosted zone. Only applicable when `create_zone = false`"
  type        = string
  default     = null
}

variable "comment" {
  description = "A comment for the hosted zone. Defaults to `Managed by Terraform`"
  type        = string
  default     = null
}

variable "delegation_set_id" {
  description = "The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone"
  type        = bool
  default     = null
}

variable "enable_accelerated_recovery" {
  description = "Whether to enable Route 53 Accelerated Recovery for the public hosted zone. When enabled, provides a 60-minute RTO for resuming DNS record management if the US East (N. Virginia) Region becomes unavailable. Only applies to public hosted zones"
  type        = bool
  default     = null
}

variable "name" {
  description = "This is the name of the hosted zone"
  type        = string
  default     = ""
}

variable "vpc" {
  description = " Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID"
  type = map(object({
    vpc_id     = string
    vpc_region = optional(string)
  }))
  default = null
}

variable "timeouts" {
  description = "Timeouts for the Route53 zone operations"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

################################################################################
# VPC Association Authorization
################################################################################

variable "vpc_association_authorizations" {
  description = "A map of VPC association authorizations to create for the Route53 zone"
  type = map(object({
    vpc_id     = string
    vpc_region = optional(string)
  }))
  default = null
}

################################################################################
# DNSSEC
################################################################################

variable "enable_dnssec" {
  description = "Whether to enable DNSSEC for the Route53 zone"
  type        = bool
  default     = false
}

variable "create_dnssec_kms_key" {
  description = "Whether to create a KMS key for DNSSEC signing"
  type        = bool
  default     = true
}

variable "dnssec_kms_key_arn" {
  description = "The ARN of the KMS key to use for DNSSEC signing. Required when `create_dnssec_kms_key` is `false`"
  type        = string
  default     = null
}

variable "dnssec_kms_key_description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
  default     = "Route53 DNSSEC KMS Key"
}

variable "dnssec_kms_key_aliases" {
  description = "A list of aliases to create. Note - due to the use of `toset()`, values must be static strings and not computed values"
  type        = list(string)
  default     = []
}

variable "dnssec_kms_key_tags" {
  description = "Additional tags to apply to the KMS key created for DNSSEC signing"
  type        = map(string)
  default     = {}
}

################################################################################
# Records
################################################################################

variable "records" {
  description = "A map of Route53 records to create in the zone. The key can be used as the subdomain name, or `name` can be used to specify the full name"
  type = map(object({
    alias = optional(object({
      evaluate_target_health = optional(bool, false)
      name                   = string
      zone_id                = string
    }))
    allow_overwrite = optional(bool)
    cidr_routing_policy = optional(object({
      collection_id = string
      location_name = string
    }))
    failover_routing_policy = optional(object({
      type = string
    }))
    geolocation_routing_policy = optional(object({
      continent   = optional(string)
      country     = optional(string)
      subdivision = optional(string)
    }))
    geoproximity_routing_policy = optional(object({
      aws_region = optional(string)
      bias       = optional(number)
      coordinates = optional(list(object({
        latitude  = number
        longitude = number
      })))
      local_zone_group = optional(string)
    }))
    health_check_id = optional(string)
    latency_routing_policy = optional(object({
      region = string
    }))
    multivalue_answer_routing_policy = optional(bool)
    name                             = optional(string)
    full_name                        = optional(string)
    records                          = optional(list(string))
    set_identifier                   = optional(string)
    ttl                              = optional(number)
    type                             = string
    weighted_routing_policy = optional(object({
      weight = number
    }))
    timeouts = optional(object({
      create = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}
