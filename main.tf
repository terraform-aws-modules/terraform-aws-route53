locals {
  zone_id   = try(aws_route53_zone.this[0].id, aws_route53_zone.ignore_vpc[0].id, data.aws_route53_zone.this[0].id, null)
  zone_name = try(aws_route53_zone.this[0].name, aws_route53_zone.ignore_vpc[0].name, data.aws_route53_zone.this[0].name, null)
}

################################################################################
# Zone
################################################################################

data "aws_route53_zone" "this" {
  count = var.create && !var.create_zone ? 1 : 0

  name         = var.name
  private_zone = var.private_zone
  vpc_id       = var.vpc_id
}

resource "aws_route53_zone" "this" {
  count = var.create && var.create_zone && !var.ignore_vpc ? 1 : 0

  comment                     = var.comment
  delegation_set_id           = var.vpc == null ? var.delegation_set_id : null
  enable_accelerated_recovery = var.vpc == null ? var.enable_accelerated_recovery : null
  force_destroy               = var.force_destroy
  name                        = var.name
  tags                        = var.tags

  dynamic "vpc" {
    for_each = var.vpc != null ? var.vpc : {}

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}

resource "aws_route53_zone" "ignore_vpc" {
  count = var.create && var.create_zone && var.ignore_vpc ? 1 : 0

  comment                     = var.comment
  delegation_set_id           = var.vpc == null ? var.delegation_set_id : null
  enable_accelerated_recovery = var.vpc == null ? var.enable_accelerated_recovery : null
  force_destroy               = var.force_destroy
  name                        = var.name
  tags                        = var.tags

  dynamic "vpc" {
    for_each = var.vpc != null ? var.vpc : {}

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  # Prevent the deletion of associated VPCs after the initial creation.
  # See documentation on aws_route53_zone_association for details
  lifecycle {
    ignore_changes = [vpc]
  }
}

################################################################################
# VPC Association Authorization
################################################################################

resource "aws_route53_vpc_association_authorization" "this" {
  for_each = var.create && var.vpc_association_authorizations != null ? var.vpc_association_authorizations : {}

  zone_id    = local.zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = each.value.vpc_region
}

################################################################################
# DNSSEC
################################################################################

resource "aws_route53_key_signing_key" "this" {
  count = var.create && var.enable_dnssec ? 1 : 0

  name                       = local.zone_name
  hosted_zone_id             = local.zone_id
  key_management_service_arn = var.create_dnssec_kms_key ? module.route53_dnssec_kms.key_arn : var.dnssec_kms_key_arn
}

resource "aws_route53_hosted_zone_dnssec" "this" {
  count = var.create && var.enable_dnssec ? 1 : 0

  hosted_zone_id = aws_route53_key_signing_key.this[0].hosted_zone_id
}

module "route53_dnssec_kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "4.0.0"

  create = var.create && var.enable_dnssec && var.create_dnssec_kms_key

  # This key must be in the us-east-1 Region per AWS API
  region = "us-east-1"

  description = var.dnssec_kms_key_description

  key_usage                = "SIGN_VERIFY"
  customer_master_key_spec = "ECC_NIST_P256"
  enable_key_rotation      = false
  enable_route53_dnssec    = true

  # Aliases
  aliases = var.dnssec_kms_key_aliases

  tags = merge(
    var.tags,
    var.dnssec_kms_key_tags
  )
}

################################################################################
# Records
################################################################################

resource "aws_route53_record" "this" {
  for_each = { for k, v in var.records : k => v if var.create }

  dynamic "alias" {
    for_each = each.value.alias != null ? [each.value.alias] : []

    content {
      evaluate_target_health = each.value.alias.evaluate_target_health
      name                   = each.value.alias.name
      zone_id                = each.value.alias.zone_id == "self" ? local.zone_id : each.value.alias.zone_id
    }
  }

  allow_overwrite = each.value.allow_overwrite

  dynamic "cidr_routing_policy" {
    for_each = each.value.cidr_routing_policy != null ? [each.value.cidr_routing_policy] : []

    content {
      collection_id = cidr_routing_policy.value.collection_id
      location_name = cidr_routing_policy.value.location_name
    }
  }

  dynamic "failover_routing_policy" {
    for_each = each.value.failover_routing_policy != null ? [each.value.failover_routing_policy] : []

    content {
      type = each.value.failover_routing_policy.type
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = each.value.geolocation_routing_policy != null ? [each.value.geolocation_routing_policy] : []

    content {
      continent   = each.value.geolocation_routing_policy.continent
      country     = each.value.geolocation_routing_policy.country
      subdivision = each.value.geolocation_routing_policy.subdivision
    }
  }

  dynamic "geoproximity_routing_policy" {
    for_each = each.value.geoproximity_routing_policy != null ? [each.value.geoproximity_routing_policy] : []

    content {
      aws_region = each.value.geoproximity_routing_policy.aws_region
      bias       = each.value.geoproximity_routing_policy.bias

      dynamic "coordinates" {
        for_each = each.value.geoproximity_routing_policy.coordinates != null ? each.value.geoproximity_routing_policy.coordinates : []

        content {
          latitude  = coordinates.value.latitude
          longitude = coordinates.value.longitude
        }
      }

      local_zone_group = each.value.geoproximity_routing_policy.local_zone_group
    }
  }

  health_check_id = each.value.health_check_id

  dynamic "latency_routing_policy" {
    for_each = each.value.latency_routing_policy != null ? [each.value.latency_routing_policy] : []

    content {
      region = each.value.latency_routing_policy.region
    }
  }

  multivalue_answer_routing_policy = each.value.multivalue_answer_routing_policy
  name                             = coalesce(each.value.full_name, try("${each.value.name}.${local.zone_name}", "${each.key}.${local.zone_name}"))
  records                          = each.value.records
  set_identifier                   = each.value.set_identifier
  ttl                              = each.value.ttl
  type                             = each.value.type

  dynamic "weighted_routing_policy" {
    for_each = each.value.weighted_routing_policy != null ? [each.value.weighted_routing_policy] : []

    content {
      weight = each.value.weighted_routing_policy.weight
    }
  }

  zone_id = local.zone_id

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
