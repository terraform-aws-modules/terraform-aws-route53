locals {
  # Terragrunt users have to provide `records_jsonencoded` as jsonencode()'d string.
  # See details: https://github.com/gruntwork-io/terragrunt/issues/1211
  records = concat(var.records, try(jsondecode(var.records_jsonencoded), []))

  # Convert `records` from list to map with unique keys
  recordsets = { for rs in local.records : try(rs.key, join(" ", compact(["${rs.name} ${rs.type}", try(rs.set_identifier, "")]))) => rs }
}

data "aws_route53_zone" "this" {
  count = var.create && (var.zone_id != null || var.zone_name != null) ? 1 : 0

  zone_id      = var.zone_id
  name         = var.zone_name
  private_zone = var.private_zone
}

resource "aws_route53_record" "this" {
  for_each = { for k, v in local.recordsets : k => v if var.create && (var.zone_id != null || var.zone_name != null) }

  zone_id = data.aws_route53_zone.this[0].zone_id

  name                             = each.value.name != "" ? (lookup(each.value, "full_name_override", false) ? each.value.name : "${each.value.name}.${data.aws_route53_zone.this[0].name}") : data.aws_route53_zone.this[0].name
  type                             = each.value.type
  ttl                              = lookup(each.value, "ttl", null)
  records                          = try(each.value.records, null)
  set_identifier                   = lookup(each.value, "set_identifier", null)
  health_check_id                  = lookup(each.value, "health_check_id", null)
  multivalue_answer_routing_policy = lookup(each.value, "multivalue_answer_routing_policy", null)
  allow_overwrite                  = lookup(each.value, "allow_overwrite", false)

  dynamic "alias" {
    for_each = length(keys(lookup(each.value, "alias", {}))) == 0 ? [] : [true]

    content {
      name                   = each.value.alias.name
      zone_id                = try(each.value.alias.zone_id, data.aws_route53_zone.this[0].zone_id)
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false)
    }
  }

  dynamic "failover_routing_policy" {
    for_each = length(keys(lookup(each.value, "failover_routing_policy", {}))) == 0 ? [] : [true]

    content {
      type = each.value.failover_routing_policy.type
    }
  }

  dynamic "latency_routing_policy" {
    for_each = length(keys(lookup(each.value, "latency_routing_policy", {}))) == 0 ? [] : [true]

    content {
      region = each.value.latency_routing_policy.region
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = length(keys(lookup(each.value, "weighted_routing_policy", {}))) == 0 ? [] : [true]

    content {
      weight = each.value.weighted_routing_policy.weight
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = length(keys(lookup(each.value, "geolocation_routing_policy", {}))) == 0 ? [] : [true]

    content {
      continent   = lookup(each.value.geolocation_routing_policy, "continent", null)
      country     = lookup(each.value.geolocation_routing_policy, "country", null)
      subdivision = lookup(each.value.geolocation_routing_policy, "subdivision", null)
    }
  }

  dynamic "geoproximity_routing_policy" {
    for_each = length(keys(lookup(each.value, "geoproximity_routing_policy", {}))) == 0 ? [] : [true]

    content {
      aws_region       = lookup(each.value.geoproximity_routing_policy, "aws_region", null)
      bias             = lookup(each.value.geoproximity_routing_policy, "bias", null)
      local_zone_group = lookup(each.value.geoproximity_routing_policy, "local_zone_group", null)

      dynamic "coordinates" {
        for_each = lookup(each.value.geoproximity_routing_policy, "coordinates", null) == null ? [] : [lookup(each.value.geoproximity_routing_policy, "coordinates", null)]

        content {
          latitude  = coordinates.value.latitude
          longitude = coordinates.value.longitude
        }
      }
    }
  }

  dynamic "cidr_routing_policy" {
    for_each = try([each.value.cidr_routing_policy], [])

    content {
      collection_id = cidr_routing_policy.value.collection_id
      location_name = cidr_routing_policy.value.location_name
    }
  }

  dynamic "timeouts" {
    for_each = try([each.value.timeouts], [])

    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
