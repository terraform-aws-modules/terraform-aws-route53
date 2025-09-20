################################################################################
# Public Zone
################################################################################

output "public_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = module.zone_public.id
}

output "public_zone_arn" {
  description = "Zone ARN of Route53 zone"
  value       = module.zone_public.arn
}

output "public_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = module.zone_public.name_servers
}

output "public_zone_primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = module.zone_public.primary_name_server
}

output "public_zone_name" {
  description = "Name of Route53 zone"
  value       = module.zone_public.name
}

output "public_zone_dnssec_signing_key_digest_value" {
  description = "A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system"
  value       = module.zone_public.dnssec_signing_key_digest_value
}

output "public_zone_dnssec_signing_key_dnskey_record" {
  description = "A string that represents a DNSKEY record"
  value       = module.zone_public.dnssec_signing_key_dnskey_record
}

output "public_zone_dnssec_signing_key_ds_record" {
  description = "A string that represents a delegation signer (DS) record"
  value       = module.zone_public.dnssec_signing_key_ds_record
}

output "public_zone_dnssec_signing_key_id" {
  description = "Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (`,`)"
  value       = module.zone_public.dnssec_signing_key_id
}

output "public_zone_dnssec_signing_key_tag" {
  description = "An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B"
  value       = module.zone_public.dnssec_signing_key_tag
}

output "public_zone_dnssec_signing_key_public_key" {
  description = "The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5"
  value       = module.zone_public.dnssec_signing_key_public_key
}

# KMS key
output "public_zone_dnssec_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.zone_public.dnssec_kms_key_arn
}

output "public_zone_dnssec_kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.zone_public.dnssec_kms_key_id
}

output "public_zone_dnssec_kms_key_region" {
  description = "The region for the key"
  value       = module.zone_public.dnssec_kms_key_region
}

output "public_zone_dnssec_kms_key_policy" {
  description = "The IAM resource policy set on the key"
  value       = module.zone_public.dnssec_kms_key_policy
}

output "public_zone_records" {
  description = "Records created in the Route53 zone"
  value       = module.zone_public.records
}

################################################################################
# Private Zone
################################################################################

output "private_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = module.zone_private.id
}

output "private_zone_arn" {
  description = "Zone ARN of Route53 zone"
  value       = module.zone_private.arn
}

output "private_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = module.zone_private.name_servers
}

output "private_zone_primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = module.zone_private.primary_name_server
}

output "private_zone_name" {
  description = "Name of Route53 zone"
  value       = module.zone_private.name
}

output "private_zone_dnssec_signing_key_digest_value" {
  description = "A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system"
  value       = module.zone_private.dnssec_signing_key_digest_value
}

output "private_zone_dnssec_signing_key_dnskey_record" {
  description = "A string that represents a DNSKEY record"
  value       = module.zone_private.dnssec_signing_key_dnskey_record
}

output "private_zone_dnssec_signing_key_ds_record" {
  description = "A string that represents a delegation signer (DS) record"
  value       = module.zone_private.dnssec_signing_key_ds_record
}

output "private_zone_dnssec_signing_key_id" {
  description = "Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (`,`)"
  value       = module.zone_private.dnssec_signing_key_id
}

output "private_zone_dnssec_signing_key_tag" {
  description = "An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B"
  value       = module.zone_private.dnssec_signing_key_tag
}

output "private_zone_dnssec_signing_key_public_key" {
  description = "The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5"
  value       = module.zone_private.dnssec_signing_key_public_key
}

# KMS key
output "private_zone_dnssec_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.zone_private.dnssec_kms_key_arn
}

output "private_zone_dnssec_kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.zone_private.dnssec_kms_key_id
}

output "private_zone_dnssec_kms_key_region" {
  description = "The region for the key"
  value       = module.zone_private.dnssec_kms_key_region
}

output "private_zone_dnssec_kms_key_policy" {
  description = "The IAM resource policy set on the key"
  value       = module.zone_private.dnssec_kms_key_policy
}

output "private_zone_records" {
  description = "Records created in the Route53 zone"
  value       = module.zone_private.records
}

################################################################################
# Inbound Resolver Endpoint
################################################################################

output "inbound_resolver_endpoint_id" {
  description = "The ID of the Resolver Endpoint"
  value       = module.resolver_endpoint_inbound.id
}

output "inbound_resolver_endpoint_arn" {
  description = "The ARN of the Resolver Endpoint"
  value       = module.resolver_endpoint_inbound.arn
}

output "inbound_resolver_endpoint_host_vpc_id" {
  description = "The VPC ID used by the Resolver Endpoint"
  value       = module.resolver_endpoint_inbound.host_vpc_id
}

output "inbound_resolver_endpoint_security_group_ids" {
  description = "Security Group IDs mapped to Resolver Endpoint"
  value       = module.resolver_endpoint_inbound.security_group_ids
}

output "inbound_resolver_endpoint_ip_addresses" {
  description = "Resolver Endpoint IP Addresses"
  value       = module.resolver_endpoint_inbound.ip_addresses
}

output "inbound_resolver_endpoint_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.resolver_endpoint_inbound.security_group_arn
}

output "inbound_resolver_endpoint_security_group_id" {
  description = "ID of the security group"
  value       = module.resolver_endpoint_inbound.security_group_id
}

output "inbound_resolver_endpoint_rules" {
  description = "Resolver Endpoint Rules created"
  value       = module.resolver_endpoint_inbound.rules
}

################################################################################
# Outbound Resolver Endpoint
################################################################################

output "outbound_resolver_endpoint_id" {
  description = "The ID of the Resolver Endpoint"
  value       = module.resolver_endpoint_outbound.id
}

output "outbound_resolver_endpoint_arn" {
  description = "The ARN of the Resolver Endpoint"
  value       = module.resolver_endpoint_outbound.arn
}

output "outbound_resolver_endpoint_host_vpc_id" {
  description = "The VPC ID used by the Resolver Endpoint"
  value       = module.resolver_endpoint_outbound.host_vpc_id
}

output "outbound_resolver_endpoint_security_group_ids" {
  description = "Security Group IDs mapped to Resolver Endpoint"
  value       = module.resolver_endpoint_outbound.security_group_ids
}

output "outbound_resolver_endpoint_ip_addresses" {
  description = "Resolver Endpoint IP Addresses"
  value       = module.resolver_endpoint_outbound.ip_addresses
}

output "outbound_resolver_endpoint_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.resolver_endpoint_outbound.security_group_arn
}

output "outbound_resolver_endpoint_security_group_id" {
  description = "ID of the security group"
  value       = module.resolver_endpoint_outbound.security_group_id
}

output "outbound_resolver_endpoint_rules" {
  description = "Resolver Endpoint Rules created"
  value       = module.resolver_endpoint_outbound.rules
}

################################################################################
# Resolver Firewall Rule Group
################################################################################

output "resolver_firewall_rule_group_arn" {
  description = "The ARN (Amazon Resource Name) of the rule group"
  value       = module.resolver_firewall_rule_group.arn
}

output "resolver_firewall_rule_group_id" {
  description = "The ID of the rule group"
  value       = module.resolver_firewall_rule_group.id
}

output "resolver_firewall_rule_group_share_status" {
  description = "Whether the rule group is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Valid values: `NOT_SHARED`, `SHARED_BY_ME`, `SHARED_WITH_ME`"
  value       = module.resolver_firewall_rule_group.share_status
}

output "resolver_firewall_rule_group_domain_lists" {
  description = "Map of all domain lists created and their attributes"
  value       = module.resolver_firewall_rule_group.domain_lists
}

output "resolver_firewall_rule_group_rules" {
  description = "Map of all rules created and their attributes"
  value       = module.resolver_firewall_rule_group.rules
}

output "s3" {
  description = "S3 bucket name used for logging"
  value       = module.s3_bucket
}
