locals {
  # terragrunt users have to provide `records_json` as jsonencode()'d string.
  # See details: https://github.com/gruntwork-io/terragrunt/issues/1211
  records = var.records_json != null ? jsondecode(var.records_json) : var.records

  # Convert `records` from list to map with unique keys
  #
  # A list of `records` values is jsonencode()'d to a string to solve issue:
  # The true result value has the wrong type:
  # element types must all match for conversion to map.
  # Ref:
  # https://github.com/terraform-aws-modules/terraform-aws-route53/issues/47
  # https://github.com/terraform-aws-modules/terraform-aws-route53/pull/39
  #
  # Choose map keys in this order:
  # - not null items from `record_map_keys`, if provided
  # - or the `map_key` attribute from the record map, if provided
  # - build one from the record name, type and optional set_identifier

  record_map_keys = length(var.record_map_keys) > 0 ? [
    for i, n in var.record_map_keys : n != null
    ? n
    : lookup(local.records[i], "map_key", join(" ", compact(["${local.records[i].name} ${local.records[i].type}", lookup(local.records[i], "set_identifier", "")])))
    ] : [
    for i, rs in local.records : lookup(rs, "map_key", join(" ", compact(["${rs.name} ${rs.type}", lookup(rs, "set_identifier", "")])))
  ]

  recordsets = {
    for i, n in local.record_map_keys : n => merge(local.records[i], {
      records = jsonencode(try(local.records[i].records, null))
    })
  }
}

data "aws_route53_zone" "this" {
  count = var.create && (var.zone_id != null || var.zone_name != null) ? 1 : 0

  zone_id      = var.zone_id
  name         = var.zone_name
  private_zone = var.private_zone
}

resource "aws_route53_record" "this" {
  for_each = var.create && (var.zone_id != null || var.zone_name != null) ? local.recordsets : tomap({})

  zone_id = data.aws_route53_zone.this[0].zone_id

  name                             = each.value.name != "" ? "${each.value.name}.${data.aws_route53_zone.this[0].name}" : data.aws_route53_zone.this[0].name
  type                             = each.value.type
  ttl                              = lookup(each.value, "ttl", null)
  records                          = jsondecode(each.value.records)
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
}
