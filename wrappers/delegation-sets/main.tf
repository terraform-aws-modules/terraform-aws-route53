module "wrapper" {
  source = "../../modules/delegation-sets"

  for_each = var.items

  create          = try(each.value.create, var.defaults.create, true)
  delegation_sets = try(each.value.delegation_sets, var.defaults.delegation_sets, {})
}
