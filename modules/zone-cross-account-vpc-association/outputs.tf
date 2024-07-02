output "aws_route53_vpc_association_authorization_id" {
  description = "ID of Route53 VPC association authorizations"
  value       = { for k, v in aws_route53_vpc_association_authorization.this : k => v.id }
}

output "aws_route53_zone_association_id" {
  description = "ID of Route53 VPC association"
  value       = { for k, v in aws_route53_zone_association.this : k => v.id }
}

output "aws_route53_zone_association_owning_account" {
  description = "The account ID of the account that created the hosted zone."
  value       = { for k, v in aws_route53_zone_association.this : k => v.owning_account }
}
