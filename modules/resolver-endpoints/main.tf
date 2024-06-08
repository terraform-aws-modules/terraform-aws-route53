locals {
  security_group_ids = var.create && var.create_security_group ? [aws_security_group.this[0].id] : var.security_group_ids
}

resource "aws_route53_resolver_endpoint" "this" {
  count = var.create ? 1 : 0

  name      = var.name
  direction = var.direction

  resolver_endpoint_type = var.type
  security_group_ids     = local.security_group_ids

  dynamic "ip_address" {
    for_each = var.subnet_ids

    content {
      subnet_id = ip_address.value
    }
  }

  protocols = var.protocols

  tags = var.tags
}

resource "aws_security_group" "this" {
  count = var.create && var.create_security_group ? 1 : 0

  name        = var.security_group_name_prefix == null ? coalesce(var.security_group_name, var.name) : null
  name_prefix = var.security_group_name_prefix
  description = var.security_group_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = toset(["tcp", "udp"])

    content {
      description = "Allow DNS"
      protocol    = ingress.value
      from_port   = 53
      to_port     = 53
      cidr_blocks = var.security_group_ingress_cidr_blocks
    }
  }

  egress {
    description = "Allow All"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.security_group_tags
}
