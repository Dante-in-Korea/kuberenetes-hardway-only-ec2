variable "name" {
    description = "name setting"
    type        = string
}

variable "cidr" {
    description = "VPC CIDR"
    type        = string
}

variable "public_subnets" {
    description = "public subnet ip list"
    type        = string
}

variable "azs" {
    description = "availability zones list"
    type        = string
}

variable "tags" {}