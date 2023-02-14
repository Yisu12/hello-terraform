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
  ami                     = "ami-0b752bf1df193a6c4"
  instance_type           = "t2.micro"
  key_name                = "clave-lucatic"
  #vpc_security_group_ids = "sg-0562854c9b1329776"

  tags = {
    Name = "ExampleServerInstance"
  }
}

resource "aws_security_group" "sg" {
  tags = {
    type = "terraform-test-security-group"
  }
}
