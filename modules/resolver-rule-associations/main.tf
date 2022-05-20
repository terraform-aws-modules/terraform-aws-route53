resource "aws_route53_resolver_rule_association" "this" {
  for_each = var.create ? var.resolver_rule_associations : tomap({})

  name             = try(each.value.name, each.key, null)
  vpc_id           = try(each.value.vpc_id, var.vpc_id)
  resolver_rule_id = lookup(each.value, "resolver_rule_id", null)
}
