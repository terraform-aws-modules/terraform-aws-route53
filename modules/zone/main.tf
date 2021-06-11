
resource aws_route53_zone this {
  name          = var.name
  comment       = var.comment
  force_destroy = var.force_destroy

  dynamic "vpc" {
    for_each = try(tolist(var.vpc), [var.vpc])

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = var.tags
}

#---

module records {
  source = "../records"

  zone_id = aws_route53_zone.this.zone_id
  private_zone = (var.vpc != [])
  records = var.records
}

# If parent zone is provided, register delegation NS records in parent zone

locals {
  parent_is_set = ((var.parent_id != null) || (var.parent_name != null))
  parent_zone_id = local.parent_is_set ? ((var.parent_id == null) ? data.aws_route53_zone.parent.0.zone_id : var.parent_id) : null
}

data aws_route53_zone parent {
  count = (local.parent_is_set && (var.parent_id == null)) ? 1 : 0
  name = var.parent_name
  private_zone = var.parent_is_private
}

resource aws_route53_record ns_records {
  count = local.parent_is_set ? 1 : 0

  zone_id = local.parent_zone_id
  name = var.name
  type = "NS"
  ttl = var.ns_ttl
  records = aws_route53_zone.this.name_servers
}
