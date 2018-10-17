provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
  version = ">= 1.20.0"
}

resource "aws_instance" "web" {
  # ...
}
