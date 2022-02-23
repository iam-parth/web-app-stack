resource "aws_instance" "web" {
  ami             = data.aws_ami.ubuntu-latest.id
  instance_type   = var.app-instance
  key_name        = "web-ser"
  subnet_id       = aws_subnet.app-private.id
  depends_on      = [aws_internet_gateway.app-gw]
  security_groups = [aws_security_group.app-private-access.id]
  tags = {
    Name        = "webserver",
    Environment = var.dev-env
    Terraform   = "true"
  }
  ebs_block_device {
    delete_on_termination = true
    volume_size           = 5
    volume_type           = "gp2"
    device_name           = "/dev/sdf"
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }
  user_data = data.template_file.app-prep.rendered
}

resource "aws_instance" "bastion" {
  ami             = data.aws_ami.ubuntu-latest.id
  instance_type   = var.app-instance
  key_name        = "web-ser"
  subnet_id       = aws_subnet.app-public.id
  depends_on      = [aws_internet_gateway.app-gw]
  security_groups = [aws_security_group.app-bastion.id]
  tags = {
    Name        = "app-bastion-${var.dev-env}",
    Environment = var.dev-env
    Terraform   = "true"
  }
}