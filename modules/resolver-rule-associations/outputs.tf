output "route53_resolver_rule_association_id" {
  description = "ID of Route53 Resolver rule associations"
  value       = { for k, v in aws_route53_resolver_rule_association.this : k => v.id }
}

output "route53_resolver_rule_association_name" {
  description = "Name of Route53 Resolver rule associations"
  value       = { for k, v in aws_route53_resolver_rule_association.this : k => v.name }
}

output "route53_resolver_rule_association_resolver_rule_id" {
  description = "ID of Route53 Resolver rule associations resolver rule"
  value       = { for k, v in aws_route53_resolver_rule_association.this : k => v.resolver_rule_id }
}
