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
| [aws_oam_sink.central_logging_sink](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_sink) | resource |
| [aws_oam_sink_policy.central_logging_sink_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_sink_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_oam_resource_types"></a> [allowed\_oam\_resource\_types](#input\_allowed\_oam\_resource\_types) | Allowed Metric Resource types that will be allowed to send Metric and Log data to the monitoring account | `list(string)` | `[]` | no |
| <a name="input_allowed_source_accounts"></a> [allowed\_source\_accounts](#input\_allowed\_source\_accounts) | AWS Account ids that will be allowed to send Metric and Log data to the monitoring account | `list(string)` | `[]` | no |
| <a name="input_allowed_source_organizations"></a> [allowed\_source\_organizations](#input\_allowed\_source\_organizations) | AWS Organization ids that will be allowed to send Metric and Log data to the monitoring account | `list(string)` | `[]` | no |
| <a name="input_sink_name"></a> [sink\_name](#input\_sink\_name) | The name of the AWS CloudWatch OAM sink. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for AWS resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allowed_accounts_ids"></a> [allowed\_accounts\_ids](#output\_allowed\_accounts\_ids) | AWS accounts allowed to share data with this monitoring account. |
| <a name="output_allowed_oam_resource_types"></a> [allowed\_oam\_resource\_types](#output\_allowed\_oam\_resource\_types) | Allowed resource types to share data with this monitoring account. |
| <a name="output_allowed_organisation_ids"></a> [allowed\_organisation\_ids](#output\_allowed\_organisation\_ids) | AWS Org Id's allowed to share data with this monitoring account. |
| <a name="output_sink_arn"></a> [sink\_arn](#output\_sink\_arn) | The ARN of CloudWatch OAM sink. |
| <a name="output_sink_id"></a> [sink\_id](#output\_sink\_id) | The name of CloudWatch OAM sink. |
| <a name="output_sink_policy"></a> [sink\_policy](#output\_sink\_policy) | policy |
<!-- END_TF_DOCS -->
