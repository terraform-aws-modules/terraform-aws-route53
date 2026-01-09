module "wrapper" {
  source = "../"

  for_each = var.items

  comment                        = try(each.value.comment, var.defaults.comment, null)
  create                         = try(each.value.create, var.defaults.create, true)
  create_dnssec_kms_key          = try(each.value.create_dnssec_kms_key, var.defaults.create_dnssec_kms_key, true)
  create_zone                    = try(each.value.create_zone, var.defaults.create_zone, true)
  delegation_set_id              = try(each.value.delegation_set_id, var.defaults.delegation_set_id, null)
  dnssec_kms_key_aliases         = try(each.value.dnssec_kms_key_aliases, var.defaults.dnssec_kms_key_aliases, [])
  dnssec_kms_key_arn             = try(each.value.dnssec_kms_key_arn, var.defaults.dnssec_kms_key_arn, null)
  dnssec_kms_key_description     = try(each.value.dnssec_kms_key_description, var.defaults.dnssec_kms_key_description, "Route53 DNSSEC KMS Key")
  dnssec_kms_key_tags            = try(each.value.dnssec_kms_key_tags, var.defaults.dnssec_kms_key_tags, {})
  enable_accelerated_recovery    = try(each.value.enable_accelerated_recovery, var.defaults.enable_accelerated_recovery, null)
  enable_dnssec                  = try(each.value.enable_dnssec, var.defaults.enable_dnssec, false)
  force_destroy                  = try(each.value.force_destroy, var.defaults.force_destroy, null)
  ignore_vpc                     = try(each.value.ignore_vpc, var.defaults.ignore_vpc, false)
  name                           = try(each.value.name, var.defaults.name, "")
  private_zone                   = try(each.value.private_zone, var.defaults.private_zone, false)
  records                        = try(each.value.records, var.defaults.records, {})
  tags                           = try(each.value.tags, var.defaults.tags, {})
  timeouts                       = try(each.value.timeouts, var.defaults.timeouts, null)
  vpc                            = try(each.value.vpc, var.defaults.vpc, null)
  vpc_association_authorizations = try(each.value.vpc_association_authorizations, var.defaults.vpc_association_authorizations, null)
  vpc_id                         = try(each.value.vpc_id, var.defaults.vpc_id, null)
}
