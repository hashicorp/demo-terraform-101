variable "github_token" {
}

variable "ami" {
}

variable "identity" {
  default = "anaconda"
}

variable "namespace" {
  default = "multi-provider-demo"
}

provider "github" {
  token        = var.github_token
  organization = "placeholder"
}

provider "aws" {
  version = ">= 1.19.0"
}

data "github_ip_ranges" "test" {
}

data "aws_ami" "ubuntu_16_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_security_group" "training" {
  name_prefix = var.namespace

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
    #cidr_blocks = data.github_ip_ranges.test.pages
  }
}

resource "aws_key_pair" "training" {
  key_name   = "${var.identity}-${var.namespace}-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu_16_04.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.training.id]

  key_name = aws_key_pair.training.id

  tags = {
    Name = "${var.identity}-simple-instance"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.example.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "ping -c 5 ${cidrhost(element(data.github_ip_ranges.test.pages, 0), 0)}",
      "ping -c 5 hashicorp.com",
    ]
  }
}

output "github_pages_ip_ranges" {
  value = data.github_ip_ranges.test.pages
}

output "public_ip" {
  value = [aws_instance.example.*.public_ip]
}

output "public_dns" {
  value = [aws_instance.example.*.public_dns]
}

