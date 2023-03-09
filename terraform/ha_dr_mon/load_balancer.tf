resource "aws_elb" "load_balancer" {
  name = "${var.common_name}-load-balancer"
  subnets = module.aws-networking.public_subnet_ids
  security_groups = [module.aws-networking.security_group_id]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    target = "HTTP:80/"
    timeout = 5
    interval = 10
    unhealthy_threshold = 2
    healthy_threshold = 2

  }
}