terraform {
  required_version = ">= 0.20.0"
}

provider "aws" {
  version = "~> 1.5"
}

module "server" {
  source = "./server"

  num_webs     = "${var.num_webs}"
  identity     = "${var.identity}"
  ami          = "${var.ami}"
  ingress_cidr = "${var.ingress_cidr}"
  public_key   = "${var.public_key}"
  private_key  = "${var.private_key}"
}
