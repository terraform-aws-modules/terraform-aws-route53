
output "route53_resolver_endpoint_id" {
  description = "The ID of the Resolver Endpoint"
  value       = try(aws_route53_resolver_endpoint.this[0].id, null)
}

output "route53_resolver_endpoint_arn" {
  description = "The ARN of the Resolver Endpoint"
  value       = try(aws_route53_resolver_endpoint.this[0].arn, null)
}

output "route53_resolver_endpoint_host_vpc_id" {
  description = "The VPC ID used by the Resolver Endpoint"
  value       = try(aws_route53_resolver_endpoint.this[0].host_vpc_id, null)
}

output "route53_resolver_endpoint_security_group_ids" {
  description = "Security Group IDs mapped to Resolver Endpoint"
  value       = try(aws_route53_resolver_endpoint.this[0].security_group_ids, null)
}

output "route53_resolver_endpoint_ip_addresses" {
  description = "Resolver Endpoint IP Addresses"
  value       = try(aws_route53_resolver_endpoint.this[0].ip_address, null)
}
