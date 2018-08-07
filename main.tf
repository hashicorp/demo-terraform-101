terraform {
  required_version = ">= 0.11.0"
}

variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "ami" {}
variable "subnet_id" {}
variable "vpc_security_group_id" {}
variable "identity" {}

variable "num_webs" {
  default = "1"
}

provider "aws" {
  version    = "~> 1.5"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "server" {
  source = "./server"

  num_webs              = "${var.num_webs}"
  ami                   = "${var.ami}"
  subnet_id             = "${var.subnet_id}"
  vpc_security_group_id = "${var.vpc_security_group_id}"
  identity              = "${var.identity}"
}

output "public_ip" {
  value = "${module.server.public_ip}"
}

output "public_dns" {
  value = "${module.server.public_dns}"
}
