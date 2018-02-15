
variable "access_key" {
  description = "The AWS access key used to provision resources"
}

variable "secret_key" {
  description = "The AWS secret key used to provision resources"
}

variable "region" {
  description = "The AWS region in which to provision resources"
  default     = "us-west-2"
}

variable "identity" {
  description = "A unique name for your resources"
}

variable "ami" {
  description = "The Amazon Machine Image for new instances."
  default     = "ami-c62eaabe"
}

variable "ingress_cidr" {
  default     = "0.0.0.0/0"
  description = "IP block from which connections to this instance will be made"
}

variable "public_key_path" {
  description = "Path on disk to the public key used to connect to this instance"
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path on disk to the private key used to connect to this instance"
  default     = "~/.ssh/id_rsa"
}

variable "num_webs" {
  description = "The number of servers to run"
  default     = "1"
}
