terraform {
  backend "s3" {
    bucket = "my-tf-test-bucket-ns3e93ikei38"
    key    = "dev/terraform.tfstate"
    region = "us-west-1"
    encrypt = true
    use_lockfile = true
  } 
  
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

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "my-tf-test-bucket-ns3e93ikei39"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}