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
  vpc_security_group_ids = ["sg-0562854c9b1329776"]

  tags = {
    Name = var.instance_name
  }
  user_data = <<EOF
        #! /bin/bash
	#!/bin/sh
	amazon-linux-extras install -y docker
	service docker start
	systemctl enable docker
	usermod -a -G docker ec2-user
	pip3 install docker-compose
  EOF
}

