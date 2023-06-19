
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
# OAM Sink
##############

module "manage_sink" {
  source                     = "./modules/sink"
  sink_name                  = "CentralLoggingSink"
  allowed_oam_resource_types = ["AWS::CloudWatch::Metric", "AWS::Logs::LogGroup", "AWS::XRay::Trace"]
  # allowed_source_accounts           = [data.aws_caller_identity.current.account_id]
  allowed_source_accounts      = ["XXXXXXXXXXXXX", "XXXXXXXXXXXXX", "XXXXXXXXXXXXX", "XXXXXXXXXXXXX"]
  allowed_source_organizations = []
}


# ##############
# # OAM Link
# ##############

module "manage_link" {
  source                     = "./modules/link"
  sink_arn                   = module.manage_sink.sink_arn
  account_label              = "$AccountName"
  allowed_oam_resource_types = ["AWS::CloudWatch::Metric", "AWS::Logs::LogGroup", "AWS::XRay::Trace"]
}
