variable "ami" {
  description = "Base machine image for running this server"
  default     = "ami-e70db29f"
}

variable "num_webs" {
  description = "The number of servers to create"
  default     = 1
}

variable "identity" {
  description = "A unique name for this server"
}

variable "security_group_id" {
  description = "The AWS security group with ingress and egress rules for this instance."
}

resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "t2.medium"
  count         = "${var.num_webs}"

  vpc_security_group_ids = ["${var.security_group_id}"]

  tags {
    "Name"       = "${var.identity} web ${count.index+1}/${var.num_webs}"
    "Identity"   = "${var.identity}"
    "Created-by" = "Terraform"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
