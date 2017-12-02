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
  default = "2"
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

resource "aws_instance" "web" {
  ami           = "${var.ami_id}"
  instance_type = "t2.micro"
  count         = "${var.total_webs}"

  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]

  tags {
    "Name"     = "web ${count.index+1}/${var.total_webs}"
    "Identity" = "${var.identity}"
    "Foo"      = "bar"
    "Zip"      = "zap"
  }
}

module "example" {
  source  = "./example-module"
  command = "echo Goodbye World"
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
