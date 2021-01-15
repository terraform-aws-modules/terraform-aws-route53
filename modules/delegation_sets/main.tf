resource "aws_route53_delegation_set" "this" {
  for_each = var.create ? var.delegation_sets : tomap({})

  reference_name = lookup(each.value, "reference_name", null)
}
