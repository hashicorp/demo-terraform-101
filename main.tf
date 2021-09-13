terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  # MODIFY this line to look for 2.27.0 or greater
  version = ">= 2.21.0"
}

data "aws_ami" "ubuntu_16_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

module "server" {
  source = "./server"

  num_webs     = var.num_webs
  identity     = var.identity
  ami          = data.aws_ami.ubuntu_16_04.image_id
  ingress_cidr = var.ingress_cidr
  public_key   = var.public_key
  private_key  = var.private_key
}

