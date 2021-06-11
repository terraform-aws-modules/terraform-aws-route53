
module zone {
  source = "../zone"
  for_each = var.zones

  name          = each.key
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  vpc = lookup(each.value, "vpc", [])
  records = lookup(each.value, "records", {})

  parent_id = lookup(each.value, "parent_id", null)
  parent_name = lookup(each.value, "parent_name", null)
  parent_is_private = lookup(each.value, "parent_is_private", false)
  ns_ttl = lookup(each.value, "ns_ttl", 300)

  tags = merge(
    lookup(each.value, "tags", {}),
    var.tags
  )
}
