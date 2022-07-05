variable "identity" {
  description = "A unique name for your resources"
}

variable "public_key" {
  description = "Contents of the public key used to connect to this instance"
  default = ""
}

variable "private_key" {
  description = "Contents of the private key used to connect to this instance"
  default = ""
}

variable "ingress_cidr" {
  description = "IP block from which connections to this instance will be made"
  default     = "0.0.0.0/0"
}

variable "num_webs" {
  description = "The number of servers to run"
  default     = "1"
}
