module "aws-networking" {
  source                   = "../modules/roadtomiddle_aws_networking"
  common_name              = var.common_name
  vpc_cidr                 = "192.168.0.0/16"
  public_subnet_cidr_list  = ["192.168.1.0/24"]
  private_subnet_cidr_list = ["192.168.2.0/24"]
  security_group_ports     = ["22", "3000"]
}

resource "aws_instance" "test-instance-1" {
  depends_on             = [module.aws-networking]
  ami                    = "ami-0557a15b87f6559cf"
  instance_type          = "t2.micro"
  subnet_id              = module.aws-networking.public_subnet_ids[0]
  vpc_security_group_ids = [module.aws-networking.security_group_id]
  user_data              = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y nodejs npm
    git clone https://github.com/harshsinghvi/todo-app.git
    cd todo-app
    npm install
    npm run build
    export MONGO_DB_URI="${data.vault_generic_secret.mongodb_credentials.data["link"]}"
    npm start
  EOF
  tags = {
    Name = "${var.common_name}-instance"
  }

}
