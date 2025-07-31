module "wrapper" {
  source = "../../modules/resolver-endpoint"

  for_each = var.items

  create                         = try(each.value.create, var.defaults.create, true)
  create_security_group          = try(each.value.create_security_group, var.defaults.create_security_group, true)
  direction                      = try(each.value.direction, var.defaults.direction, "INBOUND")
  ip_address                     = try(each.value.ip_address, var.defaults.ip_address, [])
  name                           = try(each.value.name, var.defaults.name, null)
  protocols                      = try(each.value.protocols, var.defaults.protocols, [])
  region                         = try(each.value.region, var.defaults.region, null)
  rules                          = try(each.value.rules, var.defaults.rules, {})
  security_group_description     = try(each.value.security_group_description, var.defaults.security_group_description, null)
  security_group_egress_rules    = try(each.value.security_group_egress_rules, var.defaults.security_group_egress_rules, {})
  security_group_ids             = try(each.value.security_group_ids, var.defaults.security_group_ids, [])
  security_group_ingress_rules   = try(each.value.security_group_ingress_rules, var.defaults.security_group_ingress_rules, {})
  security_group_name            = try(each.value.security_group_name, var.defaults.security_group_name, null)
  security_group_tags            = try(each.value.security_group_tags, var.defaults.security_group_tags, {})
  security_group_use_name_prefix = try(each.value.security_group_use_name_prefix, var.defaults.security_group_use_name_prefix, true)
  tags                           = try(each.value.tags, var.defaults.tags, {})
  type                           = try(each.value.type, var.defaults.type, null)
  vpc_id                         = try(each.value.vpc_id, var.defaults.vpc_id, null)
}
