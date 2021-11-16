# Name destination
variable "name" {
  type = string
#  default = "jinwoo"
}

# Region
variable "region" {
  type = string
#  default = "ap-northeast-2"
}

# availityzone
variable "ava" {
  type = list(string)
#  default = ["a","c"]
}

# Key-pair
variable "key" {
  type = string
#  default = "jinwoo-key"
}

# VPC-cidr
variable "cidr_main" {
  type = string
# default = "10.0.0.0/16"
}

# Public cidr
variable "cidr_public" {
  type = list(string)
#  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

# Private cidr
variable "cidr_private" {
  type = list(string)
#  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

# Private_db cidr
variable "cidr_private_db" {
  type = list(string)
#  default = ["10.0.4.0/24","10.0.5.0/24"]
}

# Route_cidr
variable "cidr_route" {
  type = string
#  default = "0.0.0.0/0"
}

# ipv6_cidr
variable "ipv6_cidr_blocks" {
  type = string
#  default = "::/0"
}

# port-http
variable "port_http" {
  type = number
#  default = 80
}

# protocol_tcp
variable "protocol_tcp" {
  type = string
#  default = "tcp"
}

# port_ssh
variable "port_ssh" {
  type = number
#  default = 22
}

# port_sql
variable "port_sql" {
  type = number
#  default = 3306
}

# protocol_http
variable "protocol_http" {
  type = string
#  default = "HTTP"
}