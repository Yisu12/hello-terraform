terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0b752bf1df193a6c4"
  instance_type          = "t2.micro"
  key_name               = "clave-lucatic"
  vpc_security_group_ids = ["sg-0562854c9b1329776"]

  tags = {
    Name = var.instance_name
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("/home/sinensia/.ssh/clave-lucatic.pem")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo chown -R ec2-user /var/www/html",
    ]
  }

  provisioner "file" {
    source      = "../hello-2048/public_html/"
    destination = "/var/www/html"
  }
}

