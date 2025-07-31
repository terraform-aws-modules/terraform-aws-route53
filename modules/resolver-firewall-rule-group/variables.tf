variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Firewall Rule Group
################################################################################

variable "name" {
  description = "A name that lets you identify the rule group, to manage and use it"
  type        = string
  default     = ""
}

################################################################################
# RAM Resource Association
################################################################################

variable "ram_resource_associations" {
  description = "A map of RAM resource associations for the created rule group"
  type = map(object({
    resource_share_arn = string
  }))
  default = {}
}

################################################################################
# Firewall Rules
################################################################################

variable "rules" {
  description = "A map of rule definitions to create"
  type = map(object({
    name = optional(string)

    # Domain list
    domains = optional(list(string))

    # Rule
    action                             = string
    block_override_dns_type            = optional(string)
    block_override_domain              = optional(string)
    block_override_ttl                 = optional(number)
    block_response                     = optional(string)
    firewall_domain_list_id            = optional(string)
    firewall_domain_redirection_action = optional(string)
    priority                           = number
    q_type                             = optional(string)

    tags = optional(map(string), {})
  }))
  default = {}
}
