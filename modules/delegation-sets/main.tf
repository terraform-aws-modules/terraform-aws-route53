resource "aws_route53_delegation_set" "this" {
  for_each = { for k, v in var.delegation_sets : k => v if var.create }

  reference_name = each.value.reference_name
}
