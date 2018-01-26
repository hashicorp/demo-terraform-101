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

resource "aws_security_group" "web" {
  name = "${var.identity}-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "Identity"   = "${var.identity}"
    "Created-by" = "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "t2.medium"
  count         = "${var.num_webs}"

  vpc_security_group_ids = ["${aws_security_group.web.id}"]

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
