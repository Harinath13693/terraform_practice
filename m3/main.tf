provider "aws" {
   region     = "eu-central-1"
   access_key = "AKIA3HAWNEFDMJL2SNOB"
   secret_key = "a+pqNWrHv3GQ+ONkI280xTR71qal7lsivXSa5HRz"
}

locals {
type="t2.micro"
}

resource "aws_instance" "ec2_example" {

   ami           = "ami-0767046d1677be5a0"
   instance_type =  var.instance_type

   tags = {
           Name = local.type
   }
} 

variable "instance_type" {

}

