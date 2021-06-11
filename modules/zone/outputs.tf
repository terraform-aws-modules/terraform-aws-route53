output zone_id {
  description = "Zone ID of Route53 zone"
  value       = aws_route53_zone.this.zone_id
}

output name_servers {
  description = "Name servers of Route53 zone"
  value       = aws_route53_zone.this.name_servers
}

output name {
  description = "Name of Route53 zone"
  value       = aws_route53_zone.this.name
}
