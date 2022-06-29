provider "aws" {
   region     = "ap-south-1" 
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0667149a69bc2c367"  
    instance_type = "t2.micro" 
    key_name = "aws_key"

vpc_security_group_ids = [aws_security_group.main.id]
  provisioner "file" {
    source      = "/root/prvsn_local/aws_key"
    destination = "/home/centos/aws_key"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "centos"
      private_key = file("/root/prvsn_local/id_rsa")
      timeout     = "4m"
   }
    tags = {
        Name = "provisionors_learning"
    }

  provisioner "local-exec" {
    command = "touch hello.txt"
  }
provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
}
resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDc5r0nS/Hkau1jxAgGM640kBdkX5eM8r2Rj0g0yzZUXWtw4k741Vy5XPRGrLjwrd+kHjXO0vE6zaPpLAauOv2Bh+7Ti3NHcTP2PMgiAThxf6MllL2Gz8AguY56OqNMvXMHe+clWCOheq7Io3z5/9jV+mhl/axhiZ+6RBgJHI+0jHKOJNWzHExDwbv3PA6hBUJKaIj7wXmUv9gv0w4qSXz1BIGNvcAbMUOPzuEfNr3vZIhC0bch7tabeE06QrWbw0EzTAWdFIsPDR8d0qPxDPux7qgK1tneCvFM5EZA/pFHXtcG2MPraElvcUw72/uSaNmT0pGzYKo1UkeBcARSQ4Bz root@frontt"
}
