locals {
    
    bucket_name     = "${var.environment}-ace-bucket-${var.region}"
    vpc_name        = "${var.environment}-VPC"
    subnet_name     = "${var.environment}-Subnet"
    instance_name   = "${var.environment}-EC2-Instance"
}