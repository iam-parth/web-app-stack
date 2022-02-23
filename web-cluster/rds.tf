resource "aws_db_subnet_group" "db-subnet" {
  name       = "db-private-subnet"
  subnet_ids = [aws_subnet.rds-subnet-1.id, aws_subnet.rds-subnet-2.id]
}


resource "aws_security_group" "rds-security-group" {
  vpc_id = aws_vpc.app_vpc.id
  ingress {
    description = "Allowing access to database"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.app_vpc.cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_db_instance" "db-instance" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "applicationdb"
  username             = "dbuser"
  password             = "dbpassword"
  parameter_group_name = "default.mysql5.7"
  multi_az             = false
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db-subnet.name
  #  security_group_names = [aws_security_group.rds-security-group.name]
}