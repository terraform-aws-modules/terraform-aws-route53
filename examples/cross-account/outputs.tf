################################################################################
# Zone
################################################################################

output "zone_id" {
  description = "Zone ID of Route53 zone"
  value       = module.zone.id
}

output "zone_arn" {
  description = "Zone ARN of Route53 zone"
  value       = module.zone.arn
}

output "zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = module.zone.name_servers
}

output "zone_primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = module.zone.primary_name_server
}

output "zone_name" {
  description = "Name of Route53 zone"
  value       = module.zone.name
}

output "zone_dnssec_signing_key_digest_value" {
  description = "A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system"
  value       = module.zone.dnssec_signing_key_digest_value
}

output "zone_dnssec_signing_key_dnskey_record" {
  description = "A string that represents a DNSKEY record"
  value       = module.zone.dnssec_signing_key_dnskey_record
}

output "zone_dnssec_signing_key_ds_record" {
  description = "A string that represents a delegation signer (DS) record"
  value       = module.zone.dnssec_signing_key_ds_record
}

output "zone_dnssec_signing_key_id" {
  description = "Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (`,`)"
  value       = module.zone.dnssec_signing_key_id
}

output "zone_dnssec_signing_key_tag" {
  description = "An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B"
  value       = module.zone.dnssec_signing_key_tag
}

output "zone_dnssec_signing_key_public_key" {
  description = "The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5"
  value       = module.zone.dnssec_signing_key_public_key
}

# KMS key
output "zone_dnssec_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.zone.dnssec_kms_key_arn
}

output "zone_dnssec_kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.zone.dnssec_kms_key_id
}

output "zone_dnssec_kms_key_region" {
  description = "The region for the key"
  value       = module.zone.dnssec_kms_key_region
}

output "zone_dnssec_kms_key_policy" {
  description = "The IAM resource policy set on the key"
  value       = module.zone.dnssec_kms_key_policy
}

# Records
output "zone_records" {
  description = "Records created in the Route53 zone"
  value       = module.zone.records
}
