# web-app-stack
test commit

This Terraform stack creates the following resrouces.
 - VPC
 - Private and Public subenets
 - RDS Subnets
 - Application Load balancer
 - RDS Instance (MySQL)
 - Bastion host to connect with the web instances running behind the application load balancer
 - Security Groups for rds and EC2 instances
 - SNS Topic
 - Launch template
 - Autoscalling group

## Deployment steps
 - Login to EC2 console and create a key pair named "web-ser"
 - Take the clone of main branch in your local system
 - Navigate to web-app-stack/development
 - Run `terraform init` command to install the modules
 - Run `terraform plan` before applying the changes
 - Run `terraform apply`

## Notes
 - The instances 
 - The autoscalled instances as well as initial instances will be added latest Ubuntu images
 - BUG: In the case of error related to ELB which cannot be attached to multiple subnets, you can simply re run the apply command

