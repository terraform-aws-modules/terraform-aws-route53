# zones
output "this_route53_zone_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = module.zones.this_route53_zone_zone_id
}

output "this_route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = module.zones.this_route53_zone_name_servers
}

output "this_route53_zone_name" {
  description = "Name of Route53 zone"
  value       = module.zones.this_route53_zone_name
}

# records
output "this_route53_record_name" {
  description = "The name of the record"
  value       = module.records.this_route53_record_name
}

output "this_route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = module.records.this_route53_record_fqdn
}
