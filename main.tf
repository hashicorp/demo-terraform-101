resource "aws_instance" "web" {
  # ...
}

provider "aws" {
  # MODIFY this line to look for 2.27.0 or greater
  version = ">= 2.27.0"
}
