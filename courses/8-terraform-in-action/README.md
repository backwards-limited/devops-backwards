# Terraform

## 1. Getting Started

Terraform is:
- a provisioning tool
- easy to use
- free and open source
- declarative
- cloud-agnostic
- expressive and extensible

We write Terraform configurations - in the pipeline is a CDK version much like Pulumi.

### 1.2

How the configured `provider` injects credentials into `aws_instance` when making API calls:
![Inject credentials](docs/images/inject-credentials.png)

### 1.3

How the output of the `aws_ami` data source will be chained to the input of the `aws_instance` resource.
![Data source chain](docs/images/data-source-chained-to-instance.png)

## Life Cycle of a Terraform Resource

Terraform manages resources through a `life cycle`, and so it manages state.
As well as remote/cloud resources, Terraform can also manage `local only resources` such as `creating private keys`, `self-signed certificates`, and `random IDs`.

All Terraform resources implement the resource schema interface.
The resource schema mandates, among other things, that resources define CRUD functions hooks, one each for Create(), Read(), Update(), and Delete().
Terraform invokes these hooks when certain conditions are met.

> NOTE - The two resources in the Local provider are a managed resource and an unmanaged data source.
> The managed resource implements full CRUD, while the data source only implements Read().

![Managed and unmanaged local-file life cycle](docs/images/managed-and-unmanaged.png)

### 2.2

![Local file](docs/images/local-file.png)