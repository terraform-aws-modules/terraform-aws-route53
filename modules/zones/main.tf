resource "aws_route53_zone" "this" {
  for_each = var.create ? var.zones : tomap({})

  name          = each.key
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  delegation_set_id = lookup(each.value, "delegation_set_id", null)

  dynamic "vpc" {
    for_each = length(keys(lookup(each.value, "vpc", {}))) == 0 ? [] : [lookup(each.value, "vpc", {})]

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = lookup(each.value, "tags", null)
}
