provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
  # MODIFY this line to look for 2.27.0 or greater
  version = ">= 2.27.0"
}

resource "aws_instance" "web" {
  # ...
}
