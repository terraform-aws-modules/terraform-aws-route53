output "this_route53_record_name" {
  description = "The name of the record"
  value       = module.records.this_route53_record_name
}

output "this_route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = module.records.this_route53_record_fqdn
}
