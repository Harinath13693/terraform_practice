provider "aws" {
  region     = "ap-south-1"
  access_key = var.a_key
  secret_key = var.s_key
}

resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "my_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone="ap-south-1a"

  tags = {
    Name = "sub-ap-south-1a"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.my_vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "Route_table1"
  }
}

resource "aws_route_table_association" "routeasss" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.routetable.id
}

resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone="ap-south-1b"

  tags = {
   Name = "sub-ap-south-1b"
  }
}

resource "aws_route_table" "routetable22" {
  vpc_id = aws_vpc.my_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route_table"
  }
}

resource "aws_route_table_association" "routeasss2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.routetable22.id
}


resource "aws_instance" "instance1" {
  ami           = "ami-0667149a69bc2c367"
  instance_type = "t2.micro"
  subnet_id=aws_subnet.sub1.id
 
}

resource "aws_instance" "instance2" {
  ami           = "ami-0667149a69bc2c367"
  instance_type = "t2.micro"
  subnet_id=aws_subnet.sub2.id
  vpc_security_group_ids = [
    aws_security_group.sec_group.id ]

}

resource "aws_security_group" "sec_group" {
  name        = "sec_group2"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.my_vpc.cidr_block]
    
  }


  tags = {
    Name = "security group"
  }
}


output "out_put" {
  value = "sucessful excuetion"
}
