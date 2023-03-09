data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_autoscaling_group" "autoscaling_group" {
  vpc_zone_identifier = module.aws-networking.public_subnet_ids
  min_size  = 2
  desired_capacity = 2
  max_size = 3
  launch_template {
    id = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}