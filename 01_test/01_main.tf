# 01_main
provider "aws" {
  region = var.region
}

# 00_ssh
resource "aws_key_pair" "name" {
  key_name = var.key
  #  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4mipQbNIAZk2PYJWjCHRXLHeP9SIuWp/JSXVRI3FcRGJ1fSC9NaxEZAovXFOCLgnD0HpeX5EWYSyarM1JKUAMVGsf9tZIjTH6niTzLzE4ix/yS/oMsz2ZHiwXTPFbrlO1uJ+eMF5tXB93dw5UE4S3Qs/fRitUu+3DglEGY7oTyXfQHp/n0qi/g+cOcGbzzAwoVb91FJmNMAqyk/17i4puEQkZwkR9F10PaHG4bKov2bfVEOwx3hesUaO206ipVZdTdQnBY6rPeZbiaLI+IXnJNu15RfLVY4v8aBsLnuLdiGlgcQUI2hlvHVGt8duDfehNDauBCiXOK7Jty0ucaD3tkpcu/jApjJHdnXnm9yiuZcxWUYZEOgCGUmQDBjZCXsY+j0EQyXU5oIXDrsSMzovQnZIxj6LOxBDENndq2VUgEyyBzfiUfUXwhD32eYQl3a9fXXNlQw7psUNj2GLh8C34AXjOcYCGEDrAUoATikdue3qu1Gm2I3lgUGOWNqm8PzM="
  public_key = file("../../.ssh/jinwoo-key.pub")
}

# 02_vpc
resource "aws_vpc" "jinwoo_vpc" {
  cidr_block = var.cidr_main
  tags = {
    "Name" = "${var.name}-vpc"
  }
}

# 03_subnet
resource "aws_subnet" "jinwoo-pub" {
  count             = length(var.cidr_public) #2
  vpc_id            = aws_vpc.jinwoo_vpc.id
  cidr_block        = var.cidr_public[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.ava[count.index]}"
  }
}
resource "aws_subnet" "jinwoo-pri" {
  count             = length(var.cidr_private) #2
  vpc_id            = aws_vpc.jinwoo_vpc.id
  cidr_block        = var.cidr_private[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.ava[count.index]}"
  }
}
resource "aws_subnet" "jinwoo-pridb" {
  count             = length(var.cidr_private_db)
  vpc_id            = aws_vpc.jinwoo_vpc.id
  cidr_block        = var.cidr_private_db[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pridb${var.ava[count.index]}"
  }
}

