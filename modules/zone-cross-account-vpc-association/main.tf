resource "aws_route53_vpc_association_authorization" "this" {
  for_each = { for k, v in var.zone_vpc_associations : k => v if var.create }

  provider = aws.r53_owner

  zone_id    = each.value.zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = try(each.value.vpc_region, null)
}

resource "aws_route53_zone_association" "this" {
  for_each = aws_route53_vpc_association_authorization.this

  provider = aws.vpc_owner

  vpc_id     = each.value.vpc_id
  zone_id    = each.value.zone_id
  vpc_region = try(each.value.vpc_region, null)
}
