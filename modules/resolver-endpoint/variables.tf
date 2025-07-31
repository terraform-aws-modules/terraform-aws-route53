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
# Resolver Endpoint
################################################################################

variable "direction" {
  description = " Direction of DNS queries to or from the Route 53 Resolver endpoint. Valid values are `INBOUND` (resolver forwards DNS queries to the DNS service for a VPC from your network or another VPC) or `OUTBOUND` (resolver forwards DNS queries from the DNS service for a VPC to your network or another VPC)"
  type        = string
  default     = "INBOUND"
}

variable "ip_address" {
  description = "Subnets and IP addresses in your VPC that you want DNS queries to pass through on the way from your VPCs to your network (for outbound endpoints) or on the way from your network to your VPCs (for inbound endpoints)"
  type = list(object({
    ip        = optional(string)
    ipv6      = optional(string)
    subnet_id = string
  }))
  default = []
}

variable "name" {
  description = "Friendly name of the Route 53 Resolver endpoint"
  type        = string
  default     = null
}

variable "type" {
  description = "Endpoint IP type. This endpoint type is applied to all IP addresses. Valid values are `IPV6`, `IPV4` or `DUALSTACK` (both IPv4 and IPv6)"
  type        = string
  default     = null
}

variable "protocols" {
  description = "Protocols you want to use for the Route 53 Resolver endpoint. Valid values are `DoH`, `Do53`, or `DoH-FIPS`"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "ID of one or more security groups that you want to use to control access to this VPC"
  type        = list(string)
  default     = []
}

################################################################################
# Security Group
################################################################################

variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = null
}

variable "security_group_use_name_prefix" {
  description = "Determines whether the security group name (`security_group_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "security_group_description" {
  description = "Description of the security group created"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
  default     = null
}

variable "security_group_ingress_rules" {
  description = "Security group tcp/udp on port 53 ingress rules to add to the security group created"
  type = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string), {})
  }))
  default = {}
}

variable "security_group_egress_rules" {
  description = "Security group tcp/udp on port 53 egress rules to add to the security group created"
  type = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string), {})
  }))
  default = {}
}

variable "security_group_tags" {
  description = "A map of additional tags to add to the security group created"
  type        = map(string)
  default     = {}
}

################################################################################
# Resolver Endpoint Rule(s)
################################################################################

variable "rules" {
  description = "A map of Route 53 Resolver rules & associations to create"
  type = map(object({
    # Rule
    domain_name = string
    name        = optional(string)
    rule_type   = string
    tags        = optional(map(string), {})
    target_ip = optional(list(object({
      ip       = string
      ipv6     = optional(string)
      port     = optional(number)
      protocol = optional(string)
    })))

    # Association
    vpc_id = optional(string)
  }))
  default = {}
}
