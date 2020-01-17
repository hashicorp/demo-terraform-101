variable "ami" {}

provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

resource "aws_instance" "web" {
  ami = var.ami
  instance_type = "t2.micro"
}
