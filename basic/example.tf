provider "aws" {
}

variable "amis" {
 type = "map"
 default = {
  "us-east-1" = "ami-b374d5a5"
  "us-west-1" = "ami-4b32be2b"
 }
}

variable "region" {
 default = "us-east-1"
}

resource "aws_instance" "example" {
 ami = "${lookup(var.amis, var.region)}"
 instance_type = "t2.micro"

 # provision
 provisioner "local-exec" {
  command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
 }
}

resource "aws_eip" "ip" {
 instance = "${aws_instance.example.id}"
}

output "ip" {
 value = "${aws_eip.ip.public_ip}"
}
