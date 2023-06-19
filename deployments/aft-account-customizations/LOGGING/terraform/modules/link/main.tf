terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.1"
    }
  }
}



##############
# OAM Link
##############


resource "aws_oam_link" "oam_source_link" {
  sink_identifier = local.sink_arn
  label_template  = local.account_label
  resource_types  = local.metric_resource_types
  tags            = local.tags
}
