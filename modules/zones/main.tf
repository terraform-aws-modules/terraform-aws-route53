locals {
  vpc_association_authorization = flatten([for k, v in var.zones : [for vpc in lookup(v, "external_vpcs", []) : { zone_key = k, vpc_id = vpc.vpc_id, vpc_region = lookup(vpc, "vpc_region", null) }] if var.create])
  zones_with_external_vpcs      = { for k, v in var.zones : k => v if(lookup(v, "external_vpcs", false) != false && var.create) }
  zones_without_external_vpcs   = { for k, v in var.zones : k => v if(lookup(v, "external_vpcs", false) == false && var.create) }
}
resource "aws_route53_zone" "this" {
  for_each = local.zones_without_external_vpcs

  name          = lookup(each.value, "domain_name", each.key)
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  delegation_set_id = lookup(each.value, "delegation_set_id", null)

  dynamic "vpc" {
    for_each = try(tolist(lookup(each.value, "vpc", [])), [lookup(each.value, "vpc", {})])

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = merge(
    lookup(each.value, "tags", {}),
    var.tags
  )
}
resource "aws_route53_zone" "with_external_vpcs" {
  for_each = local.zones_with_external_vpcs

  name          = lookup(each.value, "domain_name", each.key)
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  delegation_set_id = lookup(each.value, "delegation_set_id", null)

  dynamic "vpc" {
    for_each = try(tolist(lookup(each.value, "vpc", [])), [lookup(each.value, "vpc", {})])

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = merge(
    lookup(each.value, "tags", {}),
    var.tags
  )
  lifecycle {
    ignore_changes = [vpc]
  }
}
resource "aws_route53_vpc_association_authorization" "this" {
  count      = length(local.vpc_association_authorization)
  zone_id    = aws_route53_zone.with_external_vpcs[local.vpc_association_authorization[count.index].zone_key].id
  vpc_id     = local.vpc_association_authorization[count.index].vpc_id
  vpc_region = local.vpc_association_authorization[count.index].vpc_region
}
