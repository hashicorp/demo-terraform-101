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

variable "idpub" {
  description = "Contents of the public key used to connect to this instance"
}

variable "idpri" {
  description = "Contents of the private key used to connect to this instance"
}

