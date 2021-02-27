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