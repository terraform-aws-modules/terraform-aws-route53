resource "aws_route53_zone_association" "this" {
  count      = var.create ? length(var.zones_associations) : 0
  zone_id    = var.zones_associations[count.index]["zone_id"]
  vpc_id     = var.zones_associations[count.index]["vpc_id"]
  vpc_region = lookup(var.zones_associations[count.index], "vpc_region", null)
}
