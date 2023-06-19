locals {

  sink_name = var.sink_name
  tags      = var.tags

  # allowed_accounts = {
  #   Effect = "Allow"
  #   Principal = {
  #     "AWS" = var.allowed_source_accounts
  #   }
  #   Action   = ["oam:CreateLink", "oam:UpdateLink"]
  #   Resource = "*"
  #   Condition = {
  #     "ForAllValues:StringEquals" = {
  #       "oam:ResourceTypes" = var.allowed_oam_resource_types

  #     }
  #   }
  # }
  # allowed_orgs = {
  #   Effect    = "Allow"
  #   Principal = "*"
  #   Action    = ["oam:CreateLink", "oam:UpdateLink"]
  #   Resource  = "*"
  #   Condition = {
  #     "ForAllValues:StringEquals" = {
  #       "oam:ResourceTypes" = var.allowed_oam_resource_types
  #     }
  #     "ForAnyValue:StringEquals" = {
  #       "aws:PrincipalOrgID" = var.allowed_source_organizations
  #     }
  #   }
  # }

  sink_policy = templatefile("${path.module}/policy/sink.json.tmpl", {
    allowed_accounts = var.allowed_source_accounts,
    allowed_orgs     = var.allowed_source_organizations
  })
}
