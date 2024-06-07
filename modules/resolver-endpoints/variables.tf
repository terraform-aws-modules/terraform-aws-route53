variable "create" {
  description = "Whether to create Route53 resolver endpoints"
  type        = bool
  default     = true
}

variable "name" {
  description = "The resolver endpoint name"
  type        = string
}

variable "protocols" {
  description = "The resolver endpoint protocols"
  validation {
    condition = alltrue([
      for value in var.protocols : contains(["DoH", "Do53", "DoH-FIPS"], value)
    ])
    error_message = "Invalid value. Valid values are `DoH`, `Do53` and `DoH-FIPS`"
  }
  type = list(string)
}

variable "direction" {
  description = "The resolver endpoint flow direction"
  type        = string
  validation {
    condition     = contains(["INBOUND", "OUTBOUND"], var.direction)
    error_message = "Invalid value. Valid values are `INBOUND` and `OUTBOUND`"
  }
  default = "INBOUND"
}

variable "type" {
  description = "The resolver endpoint IP type"
  type        = string
  validation {
    condition     = contains(["IPV4", "IPV6"], var.type)
    error_message = "Invalid value. Valid values are `IPV4` or `IPV6`"
  }
  default = "IPV4"
}

variable "subnet_ids" {
  description = "A list of subnets where Route53 resolver endpoints will be deployed"
  validation {
    condition     = length(var.subnet_ids) >= 1
    error_message = "Invalid value. We should have at least 1 subnet."
  }
  type = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs"
  type        = list(string)
  default     = []
}

# Security Group

variable "create_security_group" {
  description = "Whether to create Security Groups for Route53 Resolver Endpoints"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The VPC ID for all the Route53 Resolver Endpoints"
  type        = string
  default     = ""
}

variable "security_group_description" {
  description = "The security group description"
  type        = string
  default     = "Managed by Terraform."
}

variable "security_group_ingress_cidr_blocks" {
  description = "A list of CIDR blocks to allow on security group"
  type        = list(string)
  default     = []
}
