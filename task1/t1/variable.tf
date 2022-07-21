variable "region" {
  description = "name of the region"
  type        = string
  default     = "ap-south-1"
}

variable "a_key" {
  type    = string
  default = "AKIA4XU2YVRQBWLGR3NJ"
}

variable "s_key" {
  type    = string
  default = "1s97GM+Cy3IGDmz/gABVV6+ViYk0MG8qH/2bZeJY"
}

variable "amii" {
  type    = string
  default = "ami-0667149a69bc2c367"
}

variable "ins_type" {
  type    = string
  default = "t2.micro"
}


variable "az1" {
  type    = string
  default = "ap-south-1a"
}
variable "az2" {
  type    = string
  default = "ap-south-1b"
}
variable "env" {
  type    = list(string)
  default = ["dev", "qa", "prod"]
}


