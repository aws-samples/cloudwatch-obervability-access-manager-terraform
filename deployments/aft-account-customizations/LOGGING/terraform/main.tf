
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
  source                       = "./modules/sink"
  sink_name                    = "CentralLoggingSink"
  allowed_oam_resource_types   = ["AWS::Logs::LogGroup", "AWS::CloudWatch::Metric", "AWS::XRay::Trace", "AWS::ApplicationInsights::Application"]
  allowed_source_accounts      = ["988814911723", "195274893729", "230253882749", "008732538448"]
  allowed_source_organizations = ["o-pd4az3tlnp"]
}


