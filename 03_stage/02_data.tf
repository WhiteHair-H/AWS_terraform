module "stage" {
  source = "../01_test"

  name             = "jinwoo"
  region           = "ap-northeast-2"
  ava              = ["a", "c"]
  key              = "jinwoo-key"
  cidr_main        = "10.0.0.0/16"
  cidr_public      = ["10.0.0.0/24", "10.0.2.0/24"]
  cidr_private     = ["10.0.1.0/24", "10.0.3.0/24"]
  cidr_private_db  = ["10.0.4.0/24", "10.0.5.0/24"]
  cidr_route       = "0.0.0.0/0"
  ipv6_cidr_blocks = "::/0"
  port_http        = 80
  protocol_tcp     = "tcp"
  port_ssh         = 22
  port_sql         = 3306
  protocol_http    = "HTTP"

}
