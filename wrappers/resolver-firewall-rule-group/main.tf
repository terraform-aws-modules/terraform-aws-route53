module "wrapper" {
  source = "../../modules/resolver-firewall-rule-group"

  for_each = var.items

  create                    = try(each.value.create, var.defaults.create, true)
  name                      = try(each.value.name, var.defaults.name, "")
  ram_resource_associations = try(each.value.ram_resource_associations, var.defaults.ram_resource_associations, {})
  region                    = try(each.value.region, var.defaults.region, null)
  rules                     = try(each.value.rules, var.defaults.rules, {})
  tags                      = try(each.value.tags, var.defaults.tags, {})
}
