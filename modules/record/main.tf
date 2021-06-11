locals {
  zone_id = (var.zone_id == null) ? data.aws_route53_zone.this.zone_id : var.zone_id
  zone_name = (var.zone_name == null) ? data.aws_route53_zone.this.name : var.zone_name

  type = upper(var.type)
}

#---

data aws_route53_zone this {
  zone_id      = var.zone_id
  name         = var.zone_name
  private_zone = var.private_zone
}

#---

resource aws_route53_record this {
  zone_id = local.zone_id

  name            = var.name != "" ? "${var.name}.${local.zone_name}" : local.zone_name
  type            = local.type
  ttl             = var.ttl
  records         = flatten([var.records])
  set_identifier  = var.set_identifier
  health_check_id = var.health_check_id

  dynamic "alias" {
    for_each = (var.alias == null) ? [] : [true]

    content {
      name                   = var.alias.name
      zone_id                = try(var.alias.zone_id, local.zone_id)
      evaluate_target_health = lookup(var.alias, "evaluate_target_health", false)
    }
  }

  dynamic "failover_routing_policy" {
    for_each = (var.failover_routing_policy == null) ? [] : [true]

    content {
      type = var.failover_routing_policy.type
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = (var.weighted_routing_policy == null) ? [] : [true]

    content {
      weight = var.weighted_routing_policy.weight
    }
  }
}
