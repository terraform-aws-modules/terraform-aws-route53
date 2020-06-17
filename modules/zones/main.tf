resource "aws_route53_zone" "this" {
  for_each = var.create ? var.zones : {}

  name          = each.key
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  //  delegation_set_id = ""
  //  vpc {
  //    vpc_id = ""
  //  }

  tags = lookup(each.value, "tags", null)
}
