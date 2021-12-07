/*
INITIALISE:
Needs to be done at least once e.g. to download provider binaries:
terraform init

APPLY:
terraform apply -var-file=dev/prod.tfvars
*/

variable "profile" {
  description = "AWS profile to authenticate"
  type        = string
}

/*
The AWS provider is responsible for understanding API interactions, making authenticated requests, and exposing resources to Terraform.

We shall use an AWS profile:

cat ~/.aws/credentials
[david]
aws_access_key_id =
aws_secret_access_key =
*/

/*
cat ~/.aws/config
[profile david]
region = eu-west-2
*/

provider "aws" {
  region = "eu-west-2"
  profile = var.profile
}

/*
  Element                             Name
     |                                  |
+----+----+                        +----+------+
|         |                        |           |
  resource     "aws_instance"       "helloworld"     {...}
              |               |
              +------+--------+
                     |                           |
              |     Type                         |
              |                                  |
              +-----------------+----------------+
                                |
                             Identifier
*/

/*
Each resource has inputs and outputs.
Inputs are called arguments, and outputs are called attributes.
Arguments are passed through the resource and are also available as resource attributes.
There are also computed attributes that are only available after the resource has been created.

     ARGUMENTS                                 ATTRIBUTES
                      +-----------------+
                      |                 |
                      |                 |
           ami ------->                 +----> ami
                      |                 |
                      |                 |
instance_type -------->                 +----> instance_tye
                      |                 |
                      |                 |
         tags -------->                 +----> tags
                      |                 |
                      |  aws_instance   |
                      |                 |
                      |                 |          ---+
                      |                 +----> id     |
                      |                 |             +---Computed
                      |                 |             |   attributes
                      |                 +----> arn ---+
                      |                 |
                      |                 |
                      +-----------------+
*/

resource "aws_instance" "helloworld" {
  # AMI for Ubuntu on eu-west-2
  ami = "ami-0ffd774e02309201f"

  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
    Description = "An EC2 instance"
  }
}

/*
Upon successful application, we will have stateful information about the resource stored in `terraform.tfstate`:
terraform show

Output cut down for brevity, showing show important attributes:
aws_instance.helloworld:
resource "aws_instance" "helloworld" {
  ami                                  = "ami-0ffd774e02309201f"
  arn                                  = "arn:aws:ec2:eu-west-2:xxxxxxxxxxx:instance/i-094ad81e063e28fe9"
  availability_zone                    = "eu-west-2c"
  id                                   = "i-094ad81e063e28fe9"
  instance_state                       = "running"
  instance_type                        = "t2.micro"
  private_dns                          = "ip-172-31-34-178.eu-west-2.compute.internal"
  private_ip                           = "172.31.34.178"
  public_dns                           = "ec2-3-8-164-143.eu-west-2.compute.amazonaws.com"
  public_ip                            = "3.8.164.143"
  security_groups                      = [
    "default",
  ]
  subnet_id                            = "subnet-96a465ff"
  vpc_security_group_ids               = [
    "sg-a769cfce",
  ]
*/

/*
TEARDOWN:
terraform destroy -var-file=dev/prod.tfvars

Confirm teardown via:
terraform show
*/