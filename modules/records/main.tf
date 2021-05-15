locals {
  # convert from list to map with unique keys
  recordsets = { for rs in var.records : join(" ", compact(["${rs.name} ${rs.type}", lookup(rs, "set_identifier", "")])) => rs }
}

module record {
  source = "../record"
  for_each = local.recordsets

  zone_id                 = var.zone_id
  zone_name               = var.zone_name
  private_zone            = var.private_zone

  name                    = each.value.name
  type                    = each.value.type
  ttl                     = lookup(each.value, "ttl", 300)
  records                 = each.value.records
  set_identifier          = lookup(each.value, "set_identifier", "")
  health_check_id         = lookup(each.value, "health_check_id", null)
  alias                   = lookup(each.value, "alias", null)
  failover_routing_policy = lookup(each.value, "failover_routing_policy", null)
  weighted_routing_policy = lookup(each.value, "weighted_routing_policy", null)
}
