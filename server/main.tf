variable "ami" {}

variable "num_webs" {}

variable "subnet_id" {}
variable "vpc_security_group_id" {}
variable "identity" {}
variable "public_key" {}
variable "private_key" {}

resource "aws_key_pair" "training" {
  key_name   = "${var.identity}-key"
  public_key = "${var.public_key}"
}

resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "t2.nano"
  count         = "${var.num_webs}"

  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_id}"]

  key_name = "${aws_key_pair.training.id}"

  tags {
    "Name"       = "web ${count.index+1}/${var.num_webs}"
    "Identity"   = "${var.identity}"
    "Created by" = "Terraform"
  }

  connection {
    user        = "ubuntu"
    private_key = "${var.private_key}"
  }

  provisioner "file" {
    source      = "assets"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
