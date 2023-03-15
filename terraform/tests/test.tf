provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "aws-networking" {
  source                   = "../modules/roadtomiddle_aws_networking"
  common_name              = "test"
  vpc_cidr                 = "192.168.0.0/16"
  public_subnet_cidr_list  = ["192.168.1.0/24", "192.168.3.0/24"]
  private_subnet_cidr_list = ["192.168.2.0/24", "192.168.4.0/24"]
  security_group_ports     = ["80", "22"]
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [module.aws-networking.vpc_id]
  }
  filter {
    name   = "tag:Tier"
    values = ["Public"]
  }
}

resource "random_shuffle" "public_subnets" {
  input = data.aws_subnets.public.ids
}

resource "aws_instance" "test-instance-1" {
  depends_on             = [module.aws-networking]
  monitoring = true
  ami                    = "ami-0557a15b87f6559cf"
  instance_type          = "t2.micro"
  subnet_id              = random_shuffle.public_subnets.result[0]
  vpc_security_group_ids = [module.aws-networking.security_group_id]
  user_data              = <<-EOF
    #!/bin/bash
    apt update
    apt install -y apache2
    myIP=`curl icanhazip.com`
    echo "Instance IP address: $myIP" > /var/www/html/index.html
    sudo service apache2 restart
  EOF
  tags = {
    Name = "${var.common_name}-instance"
  }

}


