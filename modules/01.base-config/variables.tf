variable "vpc_name" {
  type        = string
  default     = "terraform"
  description = "(Optional) name of the custom VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "Custom VPC network"
}

variable "az_list" {
  type        = list(string)
  description = "Provided list of AZ's for which subnets should be created"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of desired private subnet networks"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of desired public subnet networks"
}
