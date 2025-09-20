################################################################################
# Firewall Rule Group
################################################################################

output "arn" {
  description = "The ARN (Amazon Resource Name) of the rule group"
  value       = try(aws_route53_resolver_firewall_rule_group.this[0].arn, null)
}

output "id" {
  description = "The ID of the rule group"
  value       = try(aws_route53_resolver_firewall_rule_group.this[0].id, null)
}

output "share_status" {
  description = "Whether the rule group is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Valid values: `NOT_SHARED`, `SHARED_BY_ME`, `SHARED_WITH_ME`"
  value       = try(aws_route53_resolver_firewall_rule_group.this[0].share_status, null)
}

################################################################################
# RAM Resource Association
################################################################################

output "ram_resource_associations" {
  description = "Map of RAM resource associations created and their attributes"
  value       = aws_ram_resource_association.this
}

################################################################################
# Firewall Domain List
################################################################################

output "domain_lists" {
  description = "Map of all domain lists created and their attributes"
  value       = aws_route53_resolver_firewall_domain_list.this
}

################################################################################
# Firewall Rule
################################################################################

output "rules" {
  description = "Map of all rules created and their attributes"
  value       = aws_route53_resolver_firewall_rule.this
}
