output "link_id" {
  description = "The name of CloudWatch OAM link."
  value       = aws_oam_link.oam_source_link.link_id
}

output "link_arn" {
  description = "The ARN of CloudWatch OAM link."
  value       = aws_oam_link.oam_source_link.arn
}
