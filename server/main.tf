variable "ami" {}

variable "num_webs" {
  default = 1
}

variable "subnet_id" {}
variable "security_group_id" {}
variable "identity" {}

resource "aws_key_pair" "training" {
  key_name   = "${var.identity}-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "t2.nano"
  count         = "${var.num_webs}"

  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]

  key_name = "${aws_key_pair.training.id}"

  tags {
    "Name"     = "web ${count.index+1}/${var.num_webs}"
    "Identity" = "${var.identity}"
    "Foo"      = "bar"
    "Zip"      = "zap"
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
      "sudo cp /tmp/assets/webapp /usr/local/bin/",
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
