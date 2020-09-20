##1. Basic Variables
variable "access" {  }
variable "secret" {  }
variable "region" { default = "us-east-1" }
variable "ami" { 
	type = "map" 
	default = {
		us-east-1 = "ami-0083662ba17882949" 
		ap-south-1 = "ami-016ec067d44808c4f"
	} 
}
variable "instance-jenkins" {
	default = "t2.micro"
}
variable "instance-app" {
    default = "t2.micro"
}

variable "jenkins-count" {
	default = "1"
}
variable "app-count" {
	default = "1"
}
variable "pubkey" {
	default = "~/.ssh/demo.pem"
}
variable "key" {
        default = "demo"
}

variable "vpc_cidr_subnets" {
  default = "172.20.0.0/16"
}

variable "private_cidr_subnets" {
  type    = "list"
  default = ["172.20.20.0/24"]
}

variable "public_cidr_subnets" {
  type    = "list"
  default = ["172.20.10.0/24"]
}

variable "avalibility_zone" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}
