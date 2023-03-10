provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "aws-networking" {
  source                   = "../modules/roadtomiddle_aws_networking"
  common_name              = var.common_name
  vpc_cidr                 = "192.168.0.0/16"
  public_subnet_cidr_list  = ["192.168.1.0/24"]
  private_subnet_cidr_list = ["192.168.2.0/24"]
}

resource "aws_instance" "test-instance-1" {
  depends_on             = [module.aws-networking]
  ami                    = "ami-0557a15b87f6559cf"
  instance_type          = "t2.micro"
  subnet_id              = module.aws-networking.public_subnet_ids[0]
  vpc_security_group_ids = [module.aws-networking.security_group_id]
  user_data              = file("./prometheus_installation.sh")
  tags = {
    Name = "${var.common_name}-instance"
  }

}


