output "elb-endpoint" {
  value = aws_elb.app-elb.dns_name
}

output "bastion-ip" {
  value = aws_instance.bastion.public_ip
}