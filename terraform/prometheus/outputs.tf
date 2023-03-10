output "prometheus_instance_access_link" {
  description = "Address of Prometheus Server instance"
  value       = "${aws_instance.prometheus_instance.public_ip}:9090"
}
