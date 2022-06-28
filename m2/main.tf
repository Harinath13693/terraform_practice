provider "aws" {
  region     = "ap-south-1"
  access_key = var.a_key
  secret_key = var.s_key
}

resource "aws_instance" "ec2_based_multi_tf_variables"{
ami=var.ami_id
instance_type=var.ins_type
tags= {
name: var.tag_name
}
}
