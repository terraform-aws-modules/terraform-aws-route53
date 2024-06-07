
output "route53_resolver_endpoint_id" {
  description = "The ID of the Resolver Endpoint"
  value       = aws_route53_resolver_endpoint.this[0].id
}

output "route53_resolver_endpoint_arn" {
  description = "The ARN of the Resolver Endpoint"
  value       = aws_route53_resolver_endpoint.this[0].arn
}

output "route53_resolver_endpoint_vpc_id" {
  description = "The VPC ID used by the Resolver Endpoint"
  value       = aws_route53_resolver_endpoint.this[0].host_vpc_id
}

output "route53_resolver_endpoint_security_groups" {
  description = "Security Group IDs mapped to Resolver Endpoint"
  value       = aws_route53_resolver_endpoint.this[0].security_group_ids
}

output "route53_resolver_endpoint_ip_addresses" {
  description = "Resolver Endpoint IP Addresses"
  value       = aws_route53_resolver_endpoint.this[0].ip_address
}
