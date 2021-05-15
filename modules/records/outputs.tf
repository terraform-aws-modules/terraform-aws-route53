output name {
  description = "The name of the records"
  value       = { for k, v in module.record : k => v.name }
}

output fqdn {
  description = "FQDNs built using the zone domain and name"
  value       = { for k, v in module.record : k => v.fqdn }
}
