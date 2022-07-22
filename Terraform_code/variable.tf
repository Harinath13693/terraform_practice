variable "region" {
  description = "name of the region"
  type        = string
  default     = "ap-south-1"
}

variable "a_key" {
  type    = string
  default = "AKIASYN32K5HMIXKKMFN"
}

variable "s_key" {
  type    = string
  default = "KMb3t0QDdFwwGlAn6USgTz4bZKDOhpSmIPNSiODk"
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


