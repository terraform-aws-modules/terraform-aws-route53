variable "create" {
  description = "Whether to create Route53 resolver endpoints"
  type        = bool
  default     = true
}

variable "name" {
  description = "The resolver endpoint name"
  type        = string
  default     = null
}

variable "protocols" {
  description = "The resolver endpoint protocols"
  type        = list(string)
  default     = []
}

variable "direction" {
  description = "The resolver endpoint flow direction"
  type        = string
  default     = "INBOUND"
}

variable "type" {
  description = "The resolver endpoint IP type"
  type        = string
  default     = "IPV4"
}

variable "subnet_ids" {
  description = "A list of subnets where Route53 resolver endpoints will be deployed"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "A list of security group IDs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags for the Route53 resolver endpoint"
  type        = map(string)
  default     = {}
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

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = null
}

variable "security_group_name_prefix" {
  description = "The prefix of the security group"
  type        = string
  default     = null
}

variable "security_group_description" {
  description = "The security group description"
  type        = string
  default     = null
}

variable "security_group_ingress_cidr_blocks" {
  description = "A list of CIDR blocks to allow on security group"
  type        = list(string)
  default     = []
}

variable "security_group_tags" {
  description = "A map of tags for the security group"
  type        = map(string)
  default     = {}
}
