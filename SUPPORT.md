## Support for deploying and using this repository

Welcome to OAM! Please use tp setup cross-aaccount observability using Terraform using Amazon CloudWatch

To set up OAM, we choose one or more AWS accounts as monitoring accounts and link them with multiple source accounts. A monitoring account is a central AWS account that can view and interact with observability data generated from source accounts. A source account is an individual AWS account that generates observability data for the resources that reside in it. Source accounts share their observability data with the monitoring account.

The shared observability data can include metrics in Amazon CloudWatch, logs in Amazon CloudWatch Logs, and traces in AWS X-Ray.



### Documentation

* [User Documentation](https://docs.aws.amazon.com/OAM/latest/APIReference/Welcome.html)
* [OAM API](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/oam.html)
* [AWS CLI](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/oam/index.html)
