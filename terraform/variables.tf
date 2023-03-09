variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/24"
}

variable "common_name" {
  default = "ykushnir-road2middle"
}