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

