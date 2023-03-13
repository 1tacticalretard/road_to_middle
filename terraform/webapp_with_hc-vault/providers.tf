provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "vault" {
  address = "http://127.0.0.1:8200"
}

data "vault_generic_secret" "mongodb_credentials" {
  path = "secret/todo-app"
}