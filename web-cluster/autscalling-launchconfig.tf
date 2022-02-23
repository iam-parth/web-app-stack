resource "aws_launch_template" "web-template" {
  name_prefix   = "web-server"
  image_id      = data.aws_ami.ubuntu-latest.id
  instance_type = "t2.micro"
}
