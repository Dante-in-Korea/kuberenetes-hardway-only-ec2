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

/*
variable "private_subnets" {
    description = "private subnet ip list"
    type        = "list"
}
*/


variable "azs" {
    description = "availability zones list"
    type        = string
}

variable "tags" {
    description = "tag map"
    type = "map"
}
