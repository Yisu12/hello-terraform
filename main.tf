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
    APP  = "vue2048"
  }

  provisioner "local-exec" {
    command = "sleep 20 && ansible-playbook -i aws_ec2.yml ec2.yml"
  }
}
