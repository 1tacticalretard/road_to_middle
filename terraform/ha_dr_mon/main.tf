provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "aws-networking" {
  source                   = "../modules/roadtomiddle_aws_networking"
  common_name              = "${var.common_name}"
  vpc_cidr                 = "192.168.0.0/16"
  public_subnet_cidr_list  = ["192.168.1.0/24", "192.168.3.0/24"]
  private_subnet_cidr_list = ["192.168.2.0/24", "192.168.4.0/24"]
}