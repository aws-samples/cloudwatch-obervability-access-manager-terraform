variable "tags" {
  description = "Custom tags for AWS resources"
  type        = map(string)
  default     = {}
}

variable "sink_arn" {
  description = "ARN of the sink to use to create connection."
  type        = string
}



variable "account_label" {
  description = "Account labels to create connection. Provide either $AccountName Or $AccountEmail or $AccountEmailNoDomain"
  type        = string
}

variable "allowed_oam_resource_types" {
  description = "Allowed Metric Resource types that will be allowed to send Metric and Log data to the monitoring account"
  type        = list(string)
  default     = []
}
