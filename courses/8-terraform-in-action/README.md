# Terraform

Terraform is:
- a provisioning tool
- easy to use
- free and open source
- declarative
- cloud-agnostic
- expressive and extensible

We write Terraform configurations - in the pipeline is a CDK version much like Pulumi.

## 1.2

How the configured `provider` injects credentials into `aws_instance` when making API calls:
![Inject credentials](docs/images/inject-credentials.png)

## 1.3

How the output of the `aws_ami` data source will be chained to the input of the `aws_instance` resource.
![Data source chain](docs/images/data-source-chained-to-instance.png)