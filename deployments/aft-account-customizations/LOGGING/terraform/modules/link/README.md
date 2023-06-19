<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_oam_link.oam_source_link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_label"></a> [account\_label](#input\_account\_label) | Account labels to create connection. Provide either $AccountName Or $AccountEmail or $AccountEmailNoDomain | `string` | n/a | yes |
| <a name="input_allowed_oam_resource_types"></a> [allowed\_oam\_resource\_types](#input\_allowed\_oam\_resource\_types) | Allowed Metric Resource types that will be allowed to send Metric and Log data to the monitoring account | `list(string)` | `[]` | no |
| <a name="input_sink_arn"></a> [sink\_arn](#input\_sink\_arn) | ARN of the sink to use to create connection. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for AWS resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_link_arn"></a> [link\_arn](#output\_link\_arn) | The ARN of CloudWatch OAM link. |
| <a name="output_link_id"></a> [link\_id](#output\_link\_id) | The name of CloudWatch OAM link. |
<!-- END_TF_DOCS -->
