locals {
  // convert from list to map with unique keys
  recordsets = { for rs in var.records : "${rs.name} ${rs.type}" => rs }
}

data "aws_route53_zone" "this" {
  count = var.create && (var.zone_id != null || var.zone_name != null) ? 1 : 0

  zone_id      = var.zone_id
  name         = var.zone_name
  private_zone = var.private_zone
}

resource "aws_route53_record" "this" {
  for_each = var.create && (var.zone_id != null || var.zone_name != null) ? local.recordsets : {}

  zone_id = data.aws_route53_zone.this[0].zone_id

  name    = each.value.name != "" ? "${each.value.name}.${data.aws_route53_zone.this[0].name}" : data.aws_route53_zone.this[0].name
  type    = each.value.type
  ttl     = lookup(each.value, "ttl", null)
  records = lookup(each.value, "records", null)

  dynamic "alias" {
    for_each = length(keys(lookup(each.value, "alias", {}))) == 0 ? [] : [true]

    content {
      name                   = each.value.alias.name # module.api_gateway.this_apigatewayv2_domain_name_configuration.0.target_domain_name
      zone_id                = each.value.alias.zone_id
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false)
    }
  }
}
