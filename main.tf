terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}

provider "aws" {
}

module "server" {
  source = "./server"

  num_webs     = var.num_webs
  identity     = var.identity
  ami          = var.ami
  ingress_cidr = var.ingress_cidr
  public_key   = var.public_key
  private_key  = var.private_key
}
