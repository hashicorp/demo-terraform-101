terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  version    = "~> 1.5"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "server" {
  source = "./server"

  num_webs         = "${var.num_webs}"
  identity         = "${var.identity}"
  ami              = "${var.ami}"
  ingress_cidr     = "${var.ingress_cidr}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
}
