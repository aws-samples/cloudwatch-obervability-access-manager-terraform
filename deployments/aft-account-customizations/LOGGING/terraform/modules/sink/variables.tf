variable "tags" {
  description = "Custom tags for AWS resources"
  type        = map(string)
  default     = {}
}

variable "sink_name" {
  description = "The name of the AWS CloudWatch OAM sink."
  type        = string
}

variable "allowed_source_accounts" {
  description = "AWS Account ids that will be allowed to send Metric and Log data to the monitoring account"
  type        = list(string)
  default     = []
}

variable "allowed_source_organizations" {
  description = "AWS Organization ids that will be allowed to send Metric and Log data to the monitoring account"
  type        = list(string)
  default     = []
}

variable "allowed_oam_resource_types" {
  description = "Allowed Metric Resource types that will be allowed to send Metric and Log data to the monitoring account"
  type        = list(string)
  default     = []
}
