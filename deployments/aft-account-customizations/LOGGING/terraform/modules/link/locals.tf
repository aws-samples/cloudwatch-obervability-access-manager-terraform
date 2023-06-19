locals {
  tags                  = var.tags
  sink_arn              = var.sink_arn
  account_label         = var.account_label
  metric_resource_types = var.allowed_oam_resource_types
}
