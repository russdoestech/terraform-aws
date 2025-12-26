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

variable "instance_count" {
    description     = "Number of EC2 instances to create"
    type            = number
        default  = 1 
}

variable "monitoring" {
    description = "Enable detailed monitoring for EC2 instances"
    type = bool
        default = true
}

variable "associate_public_ip_address" {
    description = "Associate public IP address to EC2 intance"
    type = bool
        default = true
}

variable "allowed_vm_types" {
    description = "List of allowed VM types"
    type = list(string)
        default = [ "t2.micro", "t2.small", "t3.micro", "t3.small" ]
}