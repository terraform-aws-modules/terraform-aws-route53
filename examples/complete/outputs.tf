# zones
output "route53_zone_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = module.zones.route53_zone_zone_id
}

output "route53_zone_zone_arn" {
  description = "Zone ARN of Route53 zone"
  value       = module.zones.route53_zone_zone_arn
}

output "route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = module.zones.route53_zone_name_servers
}

output "route53_zone_name" {
  description = "Name of Route53 zone"
  value       = module.zones.route53_zone_name
}

output "route53_static_zone_name" {
  description = "Name of Route53 zone created statically to avoid invalid count argument error when creating records and zones simmultaneously"
  value       = module.zones.route53_static_zone_name
}

# records
output "route53_record_name" {
  description = "The name of the record"
  value       = module.records.route53_record_name
}

output "route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = module.records.route53_record_fqdn
}

# delegation sets
output "route53_delegation_set_id" {
  description = "ID of Route53 delegation set"
  value       = module.delegation_sets.route53_delegation_set_id
}

output "route53_delegation_set_name_servers" {
  description = "Name servers in the Route53 delegation set"
  value       = module.delegation_sets.route53_delegation_set_name_servers
}

# resolver rule associations
output "route53_resolver_rule_association_id" {
  description = "ID of Route53 Resolver rule associations"
  value       = module.resolver_rule_associations.route53_resolver_rule_association_id
}

output "route53_resolver_rule_association_name" {
  description = "Name of Route53 Resolver rule associations"
  value       = module.resolver_rule_associations.route53_resolver_rule_association_name
}

output "route53_resolver_rule_association_resolver_rule_id" {
  description = "ID of Route53 Resolver rule associations resolver rule"
  value       = module.resolver_rule_associations.route53_resolver_rule_association_resolver_rule_id
}
