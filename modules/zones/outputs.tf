output "zone_id" {
  description = "Zone IDs of Route53 zones"
  value       = { for k, v in module.zone : k => v.zone_id }
}

output "name_servers" {
  description = "Name servers of Route53 zones"
  value       = { for k, v in module.zone : k => v.name_servers }
}

output "name" {
  description = "Names of Route53 zones"
  value       = { for k, v in module.zone : k => v.name }
}
