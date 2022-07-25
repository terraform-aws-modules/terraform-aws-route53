output "aws_route53_zones_associations" {
  description = "Zones associations of Route53 zone and VPCs"
  value       = aws_route53_zone_association.this
}
