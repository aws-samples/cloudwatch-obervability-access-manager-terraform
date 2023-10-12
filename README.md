
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
3. Identify one Account as your **Central CloudWatch Monitoring Account** and run the **module "manage_sink"** with appropriate values. Please export credentials of the Monitoring Account and before installing the **OAM Sink** module.
4. Exports of **sink** is used as inputs to **link** module **module "manage_link"**
5. Once the **OAM Sink** is installed, export credentials of target/source account and install the **OAM Link** module.



### Deploy CloudWatch OAM via [AFT](https://docs.aws.amazon.com/controltower/latest/userguide/aft-overview.html) -

A single account is designated for Monitoring Account where `OAM Sink` is installed. You could export a monitoring account's credentials and install the `OAM Sink` Terraform module either manually or using a DevOps pipeline. Once the `OAM Sink` module setup is completed, you could use AFT Pipelines to install and link the `OAM Link` module created in the vended accounts at scale to connect to the `OAM Sink` module which was setup in the Monitoring Account. 

To achieve this setup -

1. In the `OAM Sink` module `(deployments/aft-account-customizations/LOGGING/terraform/modules/sink)`, please insert Terraform code for [remote backend using Amazon S3 with state locking using DynamoDB](https://developer.hashicorp.com/terraform/language/settings/backends/s3) and setup `OAM Sink` module by manually exporting credentials for a central monitoring account and install the module either via pipeline or manually.


2. The `OAM Link` connection with `OAM Sink` module is done using the `sink_arn` parameter `(deployments/aft-account-customizations/LOGGING/terraform/main.tf )` of the `OAM Link` module (which was installed in previous step). Insert [Terraform remote state access code](https://developer.hashicorp.com/terraform/language/state/remote-state-data) in the `OAM Link` module `(deployments/aft-account-customizations/LOGGING/terraform/modules/link)` to fetch the `sink_arn` field of the `OAM Link` module from the remote state in Amazon S3 bucket (from point 1 above). 

Alternatively, you could setup an SSM Parameter in the AFT Management Account to fetch the `sink_arn` parameter of the `OAM Link` module.

`NOTE`: It's not necessary to use remote state access to fetch the **sink_arn**. You could simply pass this value a variable in the **OAM Link** module (in point-3 below step). Storing Terraform remote state and fetching values from that state gives long term value of secure storage and reliability.

3. FInally setup `OAM Link` in each vended account using AFT's **aft-global-customizations** (preferably) or **aft-account-customizations** to connect newly vended accounts's `OAM Link` to monitoring account's `OAM Sink`



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


## Cross Account Sink to Link Connection Permission

Once the OAM Links are linked to centralized OAM Sink using the Terraform module, you can go to the central monitoring account and check the status as below - 


![oam](Images/monitoring-acc-sink1.png)

Notice the message as **Monitoring account enabled**, which means this account has the OAM Sink where OAM Link's of other accounts will connect to.


Next, you can click on the **Manage source accounts** and notice that there are source accounts configured via OAM.

![oam](Images/monitoring-acc-sink5.png)


Now, you can click on the **Resources to link accounts** and you will notice below information which suggests this is the Monitoring account abd data which is being shared from the tenant source accounts are **Metrics, Logs, Traces** and the account label as chosen in Terraform Module is **$AccountName**

```bash
Monitoring account sink ARN: arn:aws:oam:ap-south-1:XXXXXXXXXXXX:sink/22b483c6-46ac-4da1-8fdb-4c96174c3f2b
Data shared: Metrics, Logs, Traces
Defined account label: $AccountName
```

you will notice options to **approve** connection from **link** to **sink**. 

You can use either of the two options to approve tenant account to connect to monitoring account via AWS Organizations or via individual AWS Accounts. You have an option to use or run either 

```bash
- CloudFormation template to approve at AWS Organization level or at an Account level,
- Or, approve each account individually using an approval link.
```

![oam](Images/monitoring-acc-sink20.png)


For simplicity, Click on **Any Account** to approve at each account level by using the **copy url** method. Using this method, you will be given an approval link for each account. You can open a browser, paste the link and **approve link connect to sink** like below by logging into that specific account - 

![oam](Images/monitoring-acc-sink20.png)


![oam](Images/monitoring-acc-sink25.png)

![oam](Images/monitoring-acc-sink3.png)

Once you approve the connection at the tenant source account, you will see the status as **Linked** like below 

![oam](Images/monitoring-acc-sink4.png)

## Viewing Cross Account Logs post Setup

Once all the OAM Links are coonected with approvals to centralized OAM Sink, we can see all the CloudWatch logs, metrics, traces from the central monitoring account in one view from the monitoring account. 


Go to the central monitoring account and view all the cross-account logs, metrics and traces -

**For example, you can view the cross-account Log Groups from single pane of monitoring account**

![oam](Images/monitoring-acc-sink6.png)

![oam](Images/monitoring-acc-sink7.png)

**For example, you can view the cross-account CloudWatch Metrics from single pane of monitoring account**

![oam](Images/monitoring-acc-sink8.png)

![oam](Images/monitoring-acc-sink9.png)

![oam](Images/monitoring-acc-sink19.png)

### [OPTIONAL] Enable account switching from Monitoring Account and View cross-account cross-region from Monitoring Account

You can also share your CloudWatch metrics, dashboards, logs widgets, and alarms with other accounts, so that they can easily view your data using a role.

CloudWatch gives you ability to an IAM role **CloudWatch-CrossAccountSharingRole** in all the accounts which has in trust relationship all the source OAM Link accounts to assume role and show data in the same Monitoring Account AWS Console just by selecting Account accounts and/or regions in them. 

CloudWatch provides you a sample CloudFormation script to create the role when you click on Manage role in IAM. Run this script in all accounts.

```bash
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::XXXXXXXXX:root",
                    "arn:aws:iam::XXXXXXXXX:root",
                    "arn:aws:iam::XXXXXXXXX:root",
                    "arn:aws:iam::XXXXXXXXX:root"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```

[OPTIONAL] Once, above stepis done View cross-account cross-region from Monitoring Account. Go to the Monitoring Account and click on . This will allow you to easily switch views between accounts (that have granted you permission to their data), without the need to authenticate, using a selector in the console. You have three options -

```bash
Account Id Input: Manually input the account Id every time you want to change accounts

AWS Organization account selector: A dropdown selector that provides a full list of accounts in your organization

Custom account selector: Manually input a list of Account Id's to populate a dropdown selector
```


Finally, you can view the cross-account data by simply choosing the Source Link account and selecting the region to view the data -

![oam](Images/monitoring-acc-sink22.png)

![oam](Images/monitoring-acc-sink23.png)

![oam](Images/monitoring-acc-sink24.png)


### Limitations

Amazon CloudWatch Observability Access Manager (OAM) also has service limits like all AWS Services. AWS OAM has following limits. Please consider before deploying.

`OAM source account links:` Each source account can be linked to as many as 5 monitoring accounts (This quota can't be changed)

`OAM sinks:` 1 sink per account (This quota can't be changed)

Please check below documentation  here for more information.

https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_limits.html

### LICENSE

Please refer LICENSE file.