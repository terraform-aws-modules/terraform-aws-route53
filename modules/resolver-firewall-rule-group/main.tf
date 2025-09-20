################################################################################
# Firewall Rule Group
################################################################################

resource "aws_route53_resolver_firewall_rule_group" "this" {
  count = var.create ? 1 : 0

  region = var.region

  name = var.name
  tags = var.tags
}

################################################################################
# RAM Resource Association
################################################################################

resource "aws_ram_resource_association" "this" {
  for_each = { for k, v in var.ram_resource_associations : k => v if var.create }

  region = var.region

  resource_arn       = aws_route53_resolver_firewall_rule_group.this[0].arn
  resource_share_arn = each.value.resource_share_arn
}

################################################################################
# Firewall Domain List
################################################################################

resource "aws_route53_resolver_firewall_domain_list" "this" {
  # Because there is a 1:1 relationship between domain list and rule group
  # association, we have defined them under one map definition
  for_each = { for k, v in var.rules : k => v if var.create }

  region = var.region

  domains = each.value.domains
  name    = coalesce(each.value.name, each.key)

  tags = merge(
    var.tags,
    each.value.tags,
  )
}

################################################################################
# Firewall Rule
################################################################################

resource "aws_route53_resolver_firewall_rule" "this" {
  for_each = { for k, v in var.rules : k => v if var.create }

  region = var.region

  action                  = each.value.action
  block_override_dns_type = each.value.block_override_dns_type
  block_override_domain   = each.value.block_override_domain
  block_override_ttl      = each.value.block_override_ttl
  block_response          = each.value.block_response
  firewall_domain_list_id = try(coalesce(each.value.firewall_domain_list_id, aws_route53_resolver_firewall_domain_list.this[each.key].id), null)
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.this[0].id
  name                    = coalesce(each.value.name, each.key)
  priority                = each.value.priority
  q_type                  = each.value.q_type
}
