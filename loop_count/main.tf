provider "aws"{
region = "ap-south-1"
}

locals {
ami_id="ami-0667149a69bc2c367"
ins_type="t2.micro"
name="count_variable"
}

resource "aws_instance" "looping_with_count"{
ami=local.ami_id
instance_type=local.ins_type
count=var.number_instances
tags= {
Name = local.name
}
}
