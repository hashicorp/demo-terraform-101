# Copyright IBM Corp. 2017, 2026

provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

resource "aws_instance" "web" {
  # ...
}
