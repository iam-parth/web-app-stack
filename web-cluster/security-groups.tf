resource "aws_security_group" "app-public-access" {
  name        = "app-public-access-${var.dev-env}"
  description = "Allows HTTP requests publically"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "app-public-access"
    Terraform   = "True"
    Environment = var.dev-env
  }
}

resource "aws_security_group" "app-private-access" {
  name        = "app-private-access-${var.dev-env}"
  description = "Allows ELB to communicate with backend"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    description     = "ELB to EC2"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.app-public-access.id]
  }

  ingress {
    description = "Bastion to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "app-private-access"
    Terraform   = "True"
    Environment = var.dev-env
  }
}

resource "aws_security_group" "app-bastion" {
  name        = "bastion-${var.dev-env}"
  description = "Allows ELB to communicate with backend"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    description = "SSH to bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "bastion-sg"
    Terraform   = "True"
    Environment = var.dev-env
  }
}