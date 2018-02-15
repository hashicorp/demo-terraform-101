
variable "ami" {
  description = "Base machine image for running this server"
}

variable "num_webs" {
  description = "The number of servers to create"
  default     = 1
}

variable "identity" {
  description = "A unique name for this server"
}

variable "ingress_cidr" {
  description = "IP address block from which connections to this instance will be made"
}

variable "public_key_path" {
  description = "Path on disk to the public key used to connect to this instance"
}

variable "private_key_path" {
  description = "Path on disk to the private key used to connect to this instance"
}

