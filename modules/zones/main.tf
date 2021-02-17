resource "aws_route53_zone" "this" {
  for_each = var.create ? var.zones : tomap({})

  name          = each.key
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

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

# If parent zone ID is provided, register delegation NS records in parent zone

locals {
  ns_zones = var.create ? ({ for zone, value in var.zones:
    zone => ""
    if lookup(value, "parent_id", null) != null
  }) : {}
}

resource aws_route53_record ns_records {
  for_each = var.create ? local.ns_zones : {}

  zone_id = var.zones[each.key].parent_id
  name = each.key
  type = "NS"
  ttl = lookup(var.zones[each.key], "ttl", 300)
  records = aws_route53_zone.this[each.key].name_servers
}
