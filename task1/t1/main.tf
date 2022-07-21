provider "aws" {
  region     = var.region
  access_key = var.a_key
  secret_key = var.s_key
}

locals {
  ingress_rules = [{
    port        = 5000
    description = "Ingress rules for port 5000"
    },
    {
      port        = 10050
      description = "Ingree rules for port 10050"
    },
    { port        = 22
      description = " ingress rules for port 22"
    }
  ]
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-${var.region}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az1

  tags = {
    Name = "sub-${var.az1}"
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
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az2

  tags = {
    Name = "sub-${var.az2}"
  }
}

resource "aws_route_table" "routetable22" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route_table2"
  }
}

resource "aws_route_table_association" "routeasss2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.routetable22.id
}


resource "aws_instance" "instance1" {
  ami           = var.amii
  instance_type = var.ins_type
  subnet_id     = aws_subnet.sub1.id
  vpc_security_group_ids = [
  aws_security_group.sec_group.id]
  key_name                    = "aws_key"
  associate_public_ip_address = true
  count                       = length(var.env)

  tags = {
    Name = "${var.env[count.index]}-ec2-${var.az1}"
  }

}

resource "aws_instance" "instance2" {
  ami           = var.amii
  instance_type = var.ins_type
  subnet_id     = aws_subnet.sub2.id
  vpc_security_group_ids = [
  aws_security_group.sec_group.id]
  associate_public_ip_address = true
  key_name                    = "aws_key"
  count                       = length(var.env)
  tags = {
    Name = "${var.env[count.index]}-ec2-${var.az2}"
  }

}

resource "aws_security_group" "sec_group" {
  name   = "sec_group"
  vpc_id = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules


    content {

      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "security group"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1TUoyM1350LeB4cjCbU5i6tlBPKsVMDljIWnwVAcT8VZx9GT3xfQ9dzWGiWrUF2eC+H093ATxA8hoQ7Xo28v9I2y/JuOuUGtmIkkiorNGR6CHVlGBjnSUmbRGFqL8WicXY4jpNv/g+HdeBZaUpLiJmqkEB9NsTC8vvSkg/yzx/YC3MNd+/z017S3vqpGMUI6OrDs18jwgmNoEmYu9rqkpU12AimlolvDaFxI4qgVU9kYsS6072tQMAa0BxuCyfUDdhHZ0eez5IM27bVZVYit1U1tJxAuJK2plsvAcDEN/dqD9CnYDcdkJgozfqS3UJs2V9Fyas3AS+mjWjMLpoHPbU9HF4kFk6z3elWtTysYKeD+HBpwWQdLWkOM5mRIEEBOZmaW3nSIfN6IyliTMcjFk1DTCU//LYYwwuNBFKirvVOA1DYXU1BpPiWAEkAHglpiKSsYZEOLVYAeofWG/bX8VJzMoTmkc/NK+cGVWNg162QhHvMf+KPPRASUj6aiC1RU= admin@DESKTOP-QIRC02V"
}

output "out_put" {

  value = "sucessful excuetion ${var.region}"
}
