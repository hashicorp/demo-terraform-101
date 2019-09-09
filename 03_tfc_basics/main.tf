terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = var.region
  version = ">= 2.27.0"

}

  module "keypair" {
  source  = "mitchellh/dynamic-keys/aws"
  version = "2.0.0"
  name   = "${var.identity}-key"
}

module "server" {
  source = "./server"

  num_webs     = var.num_webs
  identity     = var.identity
  ami          = var.ami
  ingress_cidr = var.ingress_cidr
  key_name     = module.keypair.key_name
  private_key  = module.keypair.private_key_pem
}

