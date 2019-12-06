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

variable "public_key" {
  description = "Contents of the public key used to connect to this instance"
}

variable "private_key" {
  description = "Contents of the private key used to connect to this instance"
}

variable "num_webs" {
  description = "The number of servers to run"
  default     = "1"
}

