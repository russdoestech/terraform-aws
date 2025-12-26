output "vpc_id" {
  value = aws_vpc.example.id
}

output "ec2_id" {
  value = aws_instance.example.id
}

output "ec2_private_ip" {
  value = aws_instance.example.private_ip
}