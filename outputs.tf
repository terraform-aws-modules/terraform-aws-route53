################################################################################
# Zone
################################################################################

output "id" {
  description = "Zone ID of Route53 zone"
  value       = local.zone_id
}

output "arn" {
  description = "Zone ARN of Route53 zone"
  value       = try(aws_route53_zone.this[0].arn, aws_route53_zone.ignore_vpc[0].arn, data.aws_route53_zone.this[0].arn, null)
}

output "name_servers" {
  description = "Name servers of Route53 zone"
  value       = try(aws_route53_zone.this[0].name_servers, aws_route53_zone.ignore_vpc[0].name_servers, data.aws_route53_zone.this[0].name_servers, null)
}

output "primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = try(aws_route53_zone.this[0].primary_name_server, aws_route53_zone.ignore_vpc[0].primary_name_server, data.aws_route53_zone.this[0].primary_name_server, null)
}

output "name" {
  description = "Name of Route53 zone"
  value       = local.zone_name
}

################################################################################
# DNSSEC
################################################################################

output "dnssec_signing_key_digest_value" {
  description = "A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system"
  value       = try(aws_route53_key_signing_key.this[0].digest_value, null)
}

output "dnssec_signing_key_dnskey_record" {
  description = "A string that represents a DNSKEY record"
  value       = try(aws_route53_key_signing_key.this[0].dnskey_record, null)
}

output "dnssec_signing_key_ds_record" {
  description = "A string that represents a delegation signer (DS) record"
  value       = try(aws_route53_key_signing_key.this[0].ds_record, null)
}

output "dnssec_signing_key_id" {
  description = "Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (`,`)"
  value       = try(aws_route53_key_signing_key.this[0].id, null)
}

output "dnssec_signing_key_tag" {
  description = "An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B"
  value       = try(aws_route53_key_signing_key.this[0].key_tag, null)
}

output "dnssec_signing_key_public_key" {
  description = "The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5"
  value       = try(aws_route53_key_signing_key.this[0].public_key, null)
}

# KMS key
output "dnssec_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.route53_dnssec_kms.key_arn
}

output "dnssec_kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.route53_dnssec_kms.key_id
}

output "dnssec_kms_key_region" {
  description = "The region for the key"
  value       = module.route53_dnssec_kms.key_region
}

output "dnssec_kms_key_policy" {
  description = "The IAM resource policy set on the key"
  value       = module.route53_dnssec_kms.key_policy
}

################################################################################
# Records
################################################################################

output "records" {
  description = "Records created in the Route53 zone"
  value       = aws_route53_record.this
}
