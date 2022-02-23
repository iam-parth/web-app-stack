resource "aws_autoscaling_group" "app-autoscalling" {
  #  launch_configuration = aws_launch_configuration.app-lauchconfiguration.id
  min_size            = 1
  max_size            = 10
  load_balancers      = [aws_elb.app-elb.name]
  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_subnet.app-private.id]
  launch_template {
    id      = aws_launch_template.web-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "app-autoscalling-${var.dev-env}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app-autoscalling.id
  elb                    = aws_elb.app-elb.id
}