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

publicip = "18.133.245.226"
```

```bash
➜ ssh -i /Users/davidainslie/temp/temp-key ec2-user@18.133.245.226
```

```bash
➜ terraform destroy
```

NOTE instead of using `heredoc` for the `user_data` we could instead refer to a file (script) e.g.
```terraform
resource "aws_instance" "webserver" {
  ami = "ami-0ffd774e02309201f"
  instance_type = "t2.micro"

  tags = {
    Name        = "webserver"
    Description = "An Nginx WebServer on Ubuntu"
  }

  user_data = file("nginx.sh")

  key_name = aws_key_pair.web.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "web" {
  public_key = file("/Users/davidainslie/temp/temp-key.pub")
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

## Provisioners

Terraform has `provisioners` that essentially run tasks (scripts) on resources.
This is equivalent to AWS EC2 `user_data` which is specific to AWS.

The actual Terraform equivalent to `user_data` is `remote exec` provisioner.

We can update our `main.tf` and replace `user_data` with a `provisioner` of type `remote-exec`.
Take a look at [main.tf](../src/aws/ec2-remote-exec/main.tf) under the ec2-remote-exec directory:

```terraform
resource "aws_instance" "webserver" {
  ami = "ami-0ffd774e02309201f"
  instance_type = "t2.micro"

  tags = {
    Name        = "webserver"
    Description = "An Nginx WebServer on Ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file("/Users/davidainslie/temp/temp-key")
  }

  key_name = aws_key_pair.web.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "web" {
  public_key = file("/Users/davidainslie/temp/temp-key.pub")
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

An alternative is `local exec`.

When the server is rebooted the IP address changed. We really want an `Elastic IP Address`:

```terraform
resource "aws_instance" "webserver" {
  ami = "ami-0ffd774e02309201f"
  instance_type = "t2.micro"

  tags = {
    Name        = "webserver"
    Description = "An Nginx WebServer on Ubuntu"
  }

  user_data = file("nginx.sh")

  key_name = aws_key_pair.web.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_eip" "eip" {
  vpc = true
  instance = aws_instance.webserver.id

  provisioner "local-exec" {
    command = "echo ${aws_eip.eip.private_dns} >> /Users/davidainslie/temp/webserver-dns.txt"
  }
}

resource "aws_key_pair" "web" {
  public_key = file("/Users/davidainslie/temp/temp-key.pub")
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

Finally, note that it is best not to use a `provisioner` and instead have a custom AMI with everything already installed. 