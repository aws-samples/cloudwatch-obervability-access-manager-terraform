output "allowed_accounts_ids" {
  description = "AWS accounts allowed to share data with this monitoring account."
  value       = var.allowed_source_accounts
}

output "allowed_organisation_ids" {
  description = "AWS Org Id's allowed to share data with this monitoring account."
  value       = var.allowed_source_organizations
}

output "allowed_oam_resource_types" {
  description = "Allowed resource types to share data with this monitoring account."
  value       = var.allowed_oam_resource_types
}

output "sink_id" {
  description = "The name of CloudWatch OAM sink."
  value       = aws_oam_sink.central_logging_sink.sink_id
}

output "sink_arn" {
  description = "The ARN of CloudWatch OAM sink."
  value       = aws_oam_sink.central_logging_sink.arn
}

output "sink_policy" {
  description = "policy"
  value       = local.sink_policy
}
