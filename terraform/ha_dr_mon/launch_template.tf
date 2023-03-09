resource "aws_launch_template" "launch_template" {
  depends_on    = [module.aws-networking]
  name          = "${var.common_name}-launch_template"
  image_id      = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name      = var.aws_key_name
  network_interfaces {
    subnet_id       = module.aws-networking.public_subnet_ids[0]
    security_groups = [module.aws-networking.security_group_id]
  }
  user_data = "${base64encode(data.template_file.user_data.rendered)}"
}

data "template_file" "user_data" {
  template = <<-EOF
    #!/bin/bash
    apt update
    apt install -y apache2
    myIP=`curl icanhazip.com`
    echo "Instance IP address: $myIP" > /var/www/html/index.html
    sudo service apache2 restart
  EOF
}
