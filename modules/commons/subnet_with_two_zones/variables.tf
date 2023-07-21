variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "igw_id" {
  type = string
}

variable "public_subnets" {
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "private_subnets" {
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "database_subnets" {
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}