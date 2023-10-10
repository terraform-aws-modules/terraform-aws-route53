data "aws_caller_identity" "current" {}

resource "aws_route53_zone" "this" {
  for_each = { for k, v in var.zones : k => v if var.create }

  name          = lookup(each.value, "domain_name", each.key)
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  delegation_set_id = lookup(each.value, "delegation_set_id", null)

  dynamic "vpc" {
    for_each = try(tolist(lookup(each.value, "vpc", [])), [lookup(each.value, "vpc", {})])

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = merge(
    lookup(each.value, "tags", {}),
    var.tags
  )
}

resource "aws_kms_key" "this" {
  for_each = {
    for k, v in var.zones :
    k => v
    if var.create
    && lookup(v, "dnssec", null) == "enable"
    && lookup(v, "ksk", null) == null
  }

  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = 7
  key_usage                = "SIGN_VERIFY"
  policy = jsonencode({
    Statement = [
      {
        Action = [
          "kms:DescribeKey",
          "kms:GetPublicKey",
          "kms:Sign",
          "kms:Verify",
        ],
        Effect = "Allow"
        Principal = {
          Service = "dnssec-route53.amazonaws.com"
        }
        Resource = "*"
        Sid      = "Allow Route 53 DNSSEC Service for ${lookup(each.value, "domain_name", each.key)}",
      },
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Resource = "*"
        Sid      = "Enable IAM User Permissions for ${lookup(each.value, "domain_name", each.key)}"
      },
    ]
    Version = "2012-10-17"
  })

  tags = merge(
    lookup(each.value, "tags", {}),
    var.tags
  )
}

resource "aws_route53_key_signing_key" "this" {
  for_each = {
    for k, v in var.zones :
    k => v
    if var.create
    && lookup(v, "dnssec", null) == "enable"
  }

  hosted_zone_id             = aws_route53_zone.this["${each.key}"].id
  key_management_service_arn = !(length(lookup(each.value, "ksk", "")) > 0) ? try(aws_kms_key.this["${each.key}"].arn, null) : try(var.zones["${each.key}"].ksk, null)
  name                       = aws_route53_zone.this["${each.key}"].name
}

resource "aws_route53_hosted_zone_dnssec" "this" {
  for_each = {
    for k, v in var.zones :
    k => v
    if var.create
    && lookup(v, "dnssec", null) == "enable"
  }

  depends_on = [
    aws_route53_key_signing_key.this
  ]
  hosted_zone_id = aws_route53_key_signing_key.this["${each.key}"].hosted_zone_id
}
