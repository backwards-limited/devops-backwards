# Provisioners

## EC2

We'll provision an EC2 instance with a webserver.
We can view [EC2 AMI Locator](https://cloud-images.ubuntu.com/locator/ec2/).

[provider.tf](../src/aws/ec2/provider.tf):
```terraform
provider "aws" {
  profile = "david"
  region = "eu-west-2"
}
```

[main.tf](../src/aws/ec2/main.tf):
```terraform
resource "aws_instance" "webserver" {
  ami = "ami-0ffd774e02309201f"
  instance_type = "t2.micro"

  tags = {
    Name        = "webserver"
    Description = "An Nginx WebServer on Ubuntu"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    systemctl enable nginx
    systemctl start nginx
  EOF

  key_name = aws_key_pair.web.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "web" {
  public_key = file("/Users/davidainslie/.ssh/id_rsa.pub")
}

resource "aws_security_group" "ssh-access" {
  name = "ssh-access"
  description = "Allow SSH access from the internet"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output publicip {
  value = aws_instance.webserver.public_ip
}
```

```bash
➜ terraform init

➜ terraform plan
```

```bash
➜ terraform apply

Outputs:

publicip = "3.10.55.243"
```

```bash
➜ ssh -i /Users/davidainslie/.ssh/id_rsa ec2-user@3.10.55.243
```

```bash
➜ terraform destroy
```

## Provisioners