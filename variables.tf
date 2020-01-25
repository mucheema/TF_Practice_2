variable "aws_region" {
  default = "us-east-1"
}
variable "vpc_cidr" {
  default = "10.20.0.0/16"
}
variable "subnets_cidr" {
  type = "list"
  default = ["10.20.1.0/24","10.20.2.0/24"]
}

variable "azs" {
  type = "list"
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}
variable "webservers_ami" {
    default = "ami-09d069a04349dc3cb"
}

variable "instance_type" {
  default = "t2.micro"
}