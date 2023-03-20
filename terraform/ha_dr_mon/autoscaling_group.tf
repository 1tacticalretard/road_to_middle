resource "aws_autoscaling_group" "autoscaling_group" {
  vpc_zone_identifier = module.aws-networking.public_subnet_ids
  min_size            = 2
  desired_capacity    = 2
  max_size            = 3
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  load_balancers = [aws_elb.load_balancer.id]
  health_check_grace_period = 10
  health_check_type = "ELB"
}

resource "aws_autoscaling_policy" "bat" {
  name                   = "${module.aws-networking.common_name}-autoscaling-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 30
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}
