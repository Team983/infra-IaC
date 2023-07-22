variable "name" {
  type    = string
  default = "common"
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0"
}

variable "family" {
  type    = string
  default = "mysql8.0"
}

variable "major_engine_version" {
  type    = string
  default = "8.0"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "multi_az" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
