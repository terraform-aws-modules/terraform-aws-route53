################################################################################
# Resolver Endpoint
################################################################################

output "id" {
  description = "The ID of the Resolver Endpoint"
  value       = try(aws_route53_resolver_endpoint.this[0].id, null)
}

output "arn" {
  description = "The ARN of the Resolver Endpoint"
  value       = try(aws_route53_resolver_endpoint.this[0].arn, null)
}

output "host_vpc_id" {
  description = "The VPC ID used by the Resolver Endpoint"
  value       = try(aws_route53_resolver_endpoint.this[0].host_vpc_id, null)
}

output "security_group_ids" {
  description = "Security Group IDs mapped to Resolver Endpoint"
  value       = try(aws_route53_resolver_endpoint.this[0].security_group_ids, null)
}

output "ip_addresses" {
  description = "Resolver Endpoint IP Addresses"
  value       = try(aws_route53_resolver_endpoint.this[0].ip_address, null)
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = try(aws_security_group.this[0].arn, null)
}

output "security_group_id" {
  description = "ID of the security group"
  value       = try(aws_security_group.this[0].id, null)
}

################################################################################
# Resolver Endpoint Rule(s)
################################################################################

output "rules" {
  description = "Resolver Endpoint Rules created"
  value       = aws_route53_resolver_rule.this
}
