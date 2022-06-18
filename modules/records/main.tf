# THIS PR AND BRANCH IS "WORK IN PROGRESS". IT IS AN ATTEMPT TO FIX ISSUE 59.

########################################################################################
# IF YOU ARE READING THIS AND WANT TO TRY FIXING IT, PLEASE INCREASE THE COUNTER BELOW!
########################################################################################
# number_of_hours_spent_on_issue_59 = 20
########################################################################################

# Here is the short explanation of the problem.
# This module can be called by TF and TG, so it has to support these 3 cases:
# 1. Terraform with "known values" (static values)
# 2. Terraform with "(known after apply)" (module.s3_bucket, module.cloudfront, etc)
# 3. Terragrunt with "known values" - (TG always resolves values before calling Terraform). TG wraps values with `jsonencode()`.
# 4. Terragrunt with "unknown values"/"(known after apply)" - this is not possible with TG.

# Considerations:
# 1. Try not to change variable types very much. `type = any` is prefered.
# 2. Keep in mind different behaviour when `records` has different length, `records` or/and `alias` is specified.
# 3. The same name of resources (aws_route53_record.this) should be used for both TF and TG.
# 4. If necessary, use Terraform 1.0 as a minimum version (not newer). Terraform 0.13 can be a history, if necessary for this fix to work.

# Success criteria:
# 1. `terraform apply` in `examples/complete` should work without `-target`
# 2. `records` should include records, alias, references to `module.s3_bucket` in `name`.
# 3. At least, modules `zones`, `records`, and `terragrunt` should be enabled (not commented)

# Potential solutions that don't work for some reasons:
# https://github.com/terraform-aws-modules/terraform-aws-route53/pull/64

locals {
  # terragrunt users have to provide `records` as jsonencode()'d string.
  # See details: https://github.com/gruntwork-io/terragrunt/issues/1211

  # Hint: This is problem place!
  all_records = try(jsondecode(var.records), var.records)
  #  records = var.records
  #  tg_records = var.is_terragrunt ? jsondecode(var.records) : []
  #  records = var.is_terragrunt ? local.tg_records : var.records

  records = [for v in local.all_records : v]

  # Convert `records` from list to map with unique keys
  #
  # A list of `records` values is jsonencode()'d to a string to solve issue:
  # The true result value has the wrong type:
  # element types must all match for conversion to map.
  # Ref:
  # https://github.com/terraform-aws-modules/terraform-aws-route53/issues/47
  # https://github.com/terraform-aws-modules/terraform-aws-route53/pull/39

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
