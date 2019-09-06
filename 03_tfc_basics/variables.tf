variable "identity" {
  description = "A unique name for your resources"
}

variable "ami" {
  description = "The Amazon Machine Image for new instances."
  default     = "ami-0735ea082a1534cac"
}

variable "ingress_cidr" {
  default     = "0.0.0.0/0"
  description = "IP block from which connections to this instance will be made"
}


variable "num_webs" {
  description = "The number of servers to run"
  default     = "1"
}

variable "region" {
  default = "us-east-1"
}
