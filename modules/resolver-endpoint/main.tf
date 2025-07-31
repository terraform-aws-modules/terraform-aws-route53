################################################################################
# Resolver Endpoint
################################################################################

resource "aws_route53_resolver_endpoint" "this" {
  count = var.create ? 1 : 0

  region = var.region

  direction = var.direction

  dynamic "ip_address" {
    for_each = var.ip_address

    content {
      ip        = ip_address.value.ip
      ipv6      = ip_address.value.ipv6
      subnet_id = ip_address.value.subnet_id
    }
  }

  name                   = var.name
  resolver_endpoint_type = var.type
  security_group_ids     = concat(aws_security_group.this[*].id, var.security_group_ids)
  protocols              = var.protocols
  tags                   = var.tags
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = var.create && var.create_security_group
  security_group_name   = try(coalesce(var.security_group_name, var.name), "")
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  region = var.region

  name        = var.security_group_use_name_prefix ? null : local.security_group_name
  name_prefix = var.security_group_use_name_prefix ? "${local.security_group_name}-" : null
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    { "Name" = local.security_group_name },
    var.security_group_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "tcp" {
  for_each = { for k, v in var.security_group_ingress_rules : k => v if var.security_group_ingress_rules != null && local.create_security_group }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = 53
  ip_protocol                  = "tcp"
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    var.security_group_tags,
    { "Name" = coalesce(each.value.name, "${local.security_group_name}-${each.key}-tcp") },
    each.value.tags
  )
  to_port = 53
}

resource "aws_vpc_security_group_ingress_rule" "udp" {
  for_each = { for k, v in var.security_group_ingress_rules : k => v if var.security_group_ingress_rules != null && local.create_security_group }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = 53
  ip_protocol                  = "udp"
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    var.security_group_tags,
    { "Name" = coalesce(each.value.name, "${local.security_group_name}-${each.key}-udp") },
    each.value.tags
  )
  to_port = 53
}

resource "aws_vpc_security_group_egress_rule" "tcp" {
  for_each = { for k, v in var.security_group_egress_rules : k => v if var.security_group_egress_rules != null && local.create_security_group }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = 53
  ip_protocol                  = "tcp"
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    var.security_group_tags,
    { "Name" = coalesce(each.value.name, "${local.security_group_name}-${each.key}-tcp") },
    each.value.tags
  )
  to_port = 53
}

resource "aws_vpc_security_group_egress_rule" "udp" {
  for_each = { for k, v in var.security_group_egress_rules : k => v if var.security_group_egress_rules != null && local.create_security_group }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = 53
  ip_protocol                  = "udp"
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    var.security_group_tags,
    { "Name" = coalesce(each.value.name, "${local.security_group_name}-${each.key}-udp") },
    each.value.tags
  )
  to_port = 53
}

################################################################################
# Resolver Endpoint Rule(s)
################################################################################

resource "aws_route53_resolver_rule" "this" {
  for_each = { for k, v in var.rules : k => v if var.create && v.vpc_id != null }

  region = var.region

  domain_name          = each.value.domain_name
  name                 = coalesce(each.value.name, each.key)
  resolver_endpoint_id = each.value.rule_type == "FORWARD" ? aws_route53_resolver_endpoint.this[0].id : null
  rule_type            = each.value.rule_type

  dynamic "target_ip" {
    for_each = each.value.target_ip != null ? each.value.target_ip : []

    content {
      ip       = target_ip.value.ip
      ipv6     = target_ip.value.ipv6
      port     = target_ip.value.port
      protocol = target_ip.value.protocol
    }
  }

  tags = merge(
    var.tags,
    each.value.tags
  )
}

################################################################################
# Resolver Endpoint Rule Association(s)
################################################################################

resource "aws_route53_resolver_rule_association" "this" {
  for_each = { for k, v in var.rules : k => v if var.create && v.vpc_id != null }

  region = var.region

  name             = coalesce(each.value.name, each.key)
  resolver_rule_id = aws_route53_resolver_rule.this[each.key].id
  vpc_id           = each.value.vpc_id
}
