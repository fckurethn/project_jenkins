variable "region" {
  type    = string
  default = "s-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "tags" {
  default = {
    Owner   = "Mykhailo Babych"
    Project = "First Demo"
  }
}

variable "distro" {
  type    = string
  default = "ami-0e472ba40eb589f49"
}
