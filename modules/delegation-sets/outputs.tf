output "route53_delegation_set_id" {
  description = "ID of Route53 delegation set"
  value       = { for k, v in aws_route53_delegation_set.this : k => v.id }
}

output "route53_delegation_set_name_servers" {
  description = "Name servers in the Route53 delegation set"
  value       = { for k, v in aws_route53_delegation_set.this : k => v.name_servers }
}

output "route53_delegation_set_reference_name" {
  description = "Reference name used when the Route53 delegation set has been created"
  value       = { for k, v in aws_route53_delegation_set.this : k => v.reference_name }
}
