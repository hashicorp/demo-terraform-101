resource "aws_key_pair" "default" {
  key_name   = "${var.identity}-key"
  public_key = var.public_key
  #public_key = file("~/.ssh/id_general.pub")
}

resource "aws_security_group" "default" {
  name_prefix = var.identity

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Created-by = "Terraform"
    Identity   = var.identity
  }
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = "t2.medium"
  count         = var.num_webs

  vpc_security_group_ids = [aws_security_group.default.id]

  key_name = aws_key_pair.default.id

  tags = {
    Name     = "${var.identity} web ${count.index + 1}/${var.num_webs}"
    Identity = var.identity
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.private_key
    #private_key = file("~/.ssh/id_general")
    host        = self.public_ip
    timeout = "1m"
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
