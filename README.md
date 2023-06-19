
# Observability Access Manager

### Overview


## What is OAM?

**OAM is for centralized logging across accounts.**

To set up OAM, we choose one or more AWS accounts as monitoring accounts and link them with multiple source accounts. A monitoring account is a central AWS account that can view and interact with observability data generated from source accounts. A source account is an individual AWS account that generates observability data for the resources that reside in it. Source accounts share their observability data with the monitoring account.

The shared observability data can include metrics in Amazon CloudWatch, logs in Amazon CloudWatch Logs, and traces in AWS X-Ray.

## OAM Components

CloudWatch OAM consists of two major components which enable cross-account observability -

### Sink

A sink is a resource that represents an attachment point in a monitoring account. Source accounts can link to the sink to send observability data. After you create a sink, you must create a sink policy that allows source accounts to attach to it.


### Link

A link is a connection between a source account and a sink that you have created in a monitoring account.
Before you create a link, you must create a sink in the monitoring account and create a sink policy in that account. The sink policy must permit the source account to link to it. You can grant permission to source accounts by granting permission to an entire organization or to individual accounts.

## OAM Architecture

![oam](Images/oam.png)


## Solution Implementation

**OAM can be implemented -** 

**1. as a standalone Terraform module**

**2. or via Account orchestrator solutions like AWS Control Tower Account Factory for Terraform (AFT)**



1.	User’s need to setup Sink before any Links are created or deployed.
2.	User’s need to select an account as central account (Sink Account) where all the source accounts (linked accounts) shall send logs to the Sink accounts
3.	User’s need to enable Sink module and disable link module to setup Sink Terraform module first
4.	Post Sink module installation, user’s need to enable or setup  Link module which uses the output (Sink ARN) as input to the Link module.

### Deploy CloudWatch OAM as a standalone solution

1. Go to the directory **deployments/aft-account-customizations/LOGGING/terraform**
2. Check the **main.tf** main module which called the **OAM Sink and Link** sub-modules to deploy OAM.
3. Identify one Account as your **Central CloudWatch Monitoring Account** and run the **module "manage_sink"** with appropriate values.
4. Exports of **sink** is used as inputs to **link** module **module "manage_link"**



### Deploy CloudWatch OAM via [AFT](https://docs.aws.amazon.com/controltower/latest/userguide/aft-overview.html) -

Please follow below approach to setup using AWS Control Tower Account Factory for Terraform (AFT) and this is based on user choice of modules to implement based on Vended Account or Global implementation type –

1.	User Clones the **aft-account-customizations** or  **aft-global-customizations** AWS CodeCommit repository.
2.	User pushes the account specific customizations into **LOGGING/terraform/modules/<MODULE>** under **aft-account-customizations** and for global customizations into the **terraform/modules/<MODULE>**  under **aft-global-customizations** repository.
3.	User updates the main.tf available at **aft-account-customizations/AWSCONFIG/terraform/** to invoke the account specific customizations module and main.tf available at **aft-global-customizations/terraform/** to invoke global customizations module.
4.	If you wish to apply any module to existing vended accounts, go to AFT Management Account and run the account specific pipeline, for example **{{MEMBER-ACCOUNTID}}-customizations-pipeline** and you should see the customizations available when the AWS CodePipeline is successful.
Please check **README.MD** of each module for detailed instructions.


## Terraform Modules Overview

Below is the brief description of the modules (Sink and Link)  -

### 1.	Sink Module

Sink moduletakes inputs as below –

•	`sink_name` : The name of the Amazon CloudWatch Sink

•	`allowed_oam_resource_types` :  OAM currently supports CloudWatch Metrics/Log Groups and X-RAT traces. You can choose to enable all or any of the three supported types.

•	`allowed_source_accounts` : Source accounts who are allowed to send logs to the central CloudWatch Sink account

•	`allowed_source_organizations` : Source Control Tower Organizations who are allowed to send logs to the central CloudWatch Sink account

### 2.	Link Module

`account_label` :

You can use any of the following values -
•	$AccountName is the name of the account

•	$AccountEmail is a globally-unique email address, which includes the email domain, such as hello@example.com

•	$AccountEmailNoDomain is an email address without the domain name

`allowed_oam_resource_types` :  OAM currently supports CloudWatch Metrics/Log Groups and X-RAT traces. You can choose to enable all or any of the three supported types to be sent to Sink.


### LICENSE

Please refer LICENSE file.