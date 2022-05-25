resource "aws_route53_resolver_rule_association" "this" {
  for_each = { for k, v in var.resolver_rule_associations : k => v if var.create }

  name             = try(each.value.name, null)
  vpc_id           = try(each.value.vpc_id, var.vpc_id)
  resolver_rule_id = each.value.resolver_rule_id
}
