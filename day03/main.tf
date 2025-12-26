terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}

# create s3 bucket

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "my-tf-test-bucket-ns3e93ikei38"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}