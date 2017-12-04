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

resource "aws_key_pair" "training" {
  key_name   = "${var.identity}-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "web" {
  ami           = "${var.ami_id}"
  instance_type = "t2.nano"
  count         = "${var.total_webs}"

  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]

  key_name = "${aws_key_pair.training.id}"

  tags {
    "Name"      = "web ${count.index+1}/${var.total_webs}"
    "Identity"  = "${var.identity}"
    "Foo"       = "bar"
    "Zip"       = "zap"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "assets"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/assets/webapp /usr/local/bin/"
      "sudo chmod +x /usr/local/bin/*",
      "sudo cp /tmp/assets/webapp.service /lib/systemd/system/webapp.service",
      "sudo service webapp start",
    ]
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
