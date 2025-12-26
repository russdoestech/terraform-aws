terraform {
  backend "s3" {
    bucket          = "my-tf-test-bucket-ns3e93ikei38"
    key             = "dev/terraform.tfstate"
    region          = "us-west-1"
    encrypt         = true
    use_lockfile    = true
  } 
  
  required_providers {
    aws             = {
      source        = "hashicorp/aws"
      version       = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region            = "us-west-1"
}

variable "environment" {
    default         = "dev"
    type            = string
}

variable "region" {
    default         = "us-west-1"
    type            = string
}

variable "zone" {
    default         = "us-west-1a"
    type            = string 
}
locals {
    
    bucket_name     = "${var.environment}-ace-bucket-${var.region}"
    vpc_name        = "${var.environment}-VPC"
    subnet_name     = "${var.environment}-Subnet"
    instance_name   = "${var.environment}-EC2-Instance"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket            = local.bucket_name

  tags              = {
    Name            = local.bucket_name
    Environment     = var.environment
  }
}

resource "aws_vpc" "example" {
  cidr_block        = "172.16.0.0/16"
  region            = var.region
  tags              = {
    Environment     = var.environment
    Name            = local.vpc_name
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "172.16.10.0/24"
  region            = var.region
  availability_zone = var.zone

  tags              = {
    Name            = local.subnet_name
    Environment     = var.environment
  }
}

resource "aws_instance" "example" {
  ami               = "ami-00263eb1b1ff67352" # Amazon Ubuntu minimal 22.04
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.example.id
  region            = var.region
  availability_zone = var.zone
  tags              = {
    Name            = local.instance_name
    Environment     = var.environment
    }
}

output "vpc_id" {
  value = aws_vpc.example.id
}

output "ec2_id" {
  value = aws_instance.example.id
}

output "ec2_private_ip" {
  value = aws_instance.example.private_ip
}