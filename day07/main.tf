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
  count             = var.instance_count
  ami               = "ami-00263eb1b1ff67352" # Amazon Ubuntu minimal 22.04
  instance_type     = var.allowed_vm_types[1]
  subnet_id         = aws_subnet.example.id
  region            = var.region
  availability_zone = var.zone
  monitoring        = var.monitoring
  associate_public_ip_address = var.associate_public_ip_address

  tags              = {
    Name            = local.instance_name
    Environment     = var.environment
    }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.example.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.example.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
