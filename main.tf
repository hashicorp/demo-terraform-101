terraform {
  required_version = ">= 0.11.0"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {}
variable "subnet_id" {}
variable "security_group_id" {}
variable "identity" {}

variable "total_webs" {
  default = "1"
}

# terraform {
#   backend "atlas" {
#     name = "sethvargo/training"
#   }
# }

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

module "webserver" {
  source = "./webserver"

  total_webs        = 1
  ami_id            = "${var.ami_id}"
  subnet_id         = "${var.subnet_id}"
  security_group_id = "${var.security_group_id}"
  identity          = "${var.identity}"
}

output "public_ip" {
  value = "${module.webserver.public_ip}"
}

output "public_dns" {
  value = "${module.webserver.public_dns}"
}
