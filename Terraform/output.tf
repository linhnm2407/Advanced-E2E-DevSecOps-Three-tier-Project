output "public-ip" {
  value = aws_instance.ec2.public_ip
  description = "EC2 Public IP"
}