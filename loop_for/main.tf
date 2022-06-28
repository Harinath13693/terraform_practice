provider "aws"{
region="ap-south-1"
}

variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
} 

output "print_the_names" {
  value = [for name in var.user_names : name]
}
