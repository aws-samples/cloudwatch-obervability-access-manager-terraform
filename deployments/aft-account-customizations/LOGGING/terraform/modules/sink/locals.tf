locals {
  sink_name = var.sink_name
  tags      = var.tags

  sink_policy = <<-EOT
  {
    "Version": "2012-10-17",
    "Statement": [
      %{if length(var.allowed_source_accounts) > 0 || length(var.allowed_source_organizations) > 0~}
      %{if length(var.allowed_source_accounts) > 0~}
      {
        "Effect": "Allow",
        "Principal": { "AWS": [%{for account in var.allowed_source_accounts~}"${account}"${account != var.allowed_source_accounts[length(var.allowed_source_accounts) - 1] ? "," : ""}%{endfor}] },
        "Action": ["oam:CreateLink", "oam:UpdateLink"],
        "Resource": "*",
        "Condition": {
          "ForAllValues:StringEquals": {
            "oam:ResourceTypes": [%{for resource_type in var.allowed_oam_resource_types~}"${resource_type}"${resource_type != var.allowed_oam_resource_types[length(var.allowed_oam_resource_types) - 1] ? "," : ""}%{endfor}]
          }
        }
      }
      %{endif~}
      %{if length(var.allowed_source_organizations) > 0~}
      %{if length(var.allowed_source_accounts) > 0},%{endif}
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": ["oam:CreateLink", "oam:UpdateLink"],
        "Resource": "*",
        "Condition": {
          "ForAllValues:StringEquals": {
            "oam:ResourceTypes": [%{for resource_type in var.allowed_oam_resource_types~}"${resource_type}"${resource_type != var.allowed_oam_resource_types[length(var.allowed_oam_resource_types) - 1] ? "," : ""}%{endfor}]
          },
          "ForAnyValue:StringEquals": {
            "aws:PrincipalOrgID": [%{for org in var.allowed_source_organizations~}"${org}"${org != var.allowed_source_organizations[length(var.allowed_source_organizations) - 1] ? "," : ""}%{endfor}]
          }
        }
      }
      %{endif~}
      %{endif~}
    ]
  }
  EOT
}