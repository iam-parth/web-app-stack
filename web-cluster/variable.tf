variable "dev-env" {
  description = "app development environment"
  default     = "dev"
}

variable "app-cidr" {
  description = "CIDR range for the VPC"
  default     = "10.0.0.0/16"
}

variable "app-private" {
  description = "CIDR range for app-private subnet"
  default     = "10.0.1.0/24"
}

variable "app-public" {
  description = "CIDR range for app-public subnet"
  default     = "10.0.2.0/24"
}

variable "app-instance" {
  description = "Instance type of EC2 instance"
  default     = "t2.micro"
}

variable "public_ip" {
  description = "Public IP address to enable the SSH access on bastion host"
  default     = "103.226.186.45/32"
}

variable "rds-private-1" {
  description = "CIDR range for app-private subnet"
  default     = "10.0.3.0/24"
}


variable "rds-private-2" {
  description = "CIDR range for app-private subnet"
  default     = "10.0.4.0/24"
}
