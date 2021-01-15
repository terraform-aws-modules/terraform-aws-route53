output "this_route53_delegation_set_id" {
  description = "ID of Route53 delegation set"
  value       = { for k, v in aws_route53_delegation_set.this : k => v.id }
}

output "this_route53_delegation_set_name_servers" {
  description = "Name servers of Route53 delegation set"
  value       = { for k, v in aws_route53_delegation_set.this : k => v.name_servers }
}
