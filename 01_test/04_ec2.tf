# 10_sg
resource "aws_security_group" "jinwoo-sg" {
  name        = "Allow Basic"
  description = "Allow HTTP,SSH,SQL,ICMP"
  vpc_id      = aws_vpc.jinwoo_vpc.id

  # HTTP 허용
  ingress = [
    {
      description      = "Allow HTTP"
      from_port        = var.port_http
      to_port          = var.port_http
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr_blocks]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow SSH"
      from_port        = var.port_ssh
      to_port          = var.port_ssh
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr_blocks]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow SQL"
      from_port        = var.port_sql
      to_port          = var.port_sql
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr_blocks]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow ICMP"
      from_port        = 0
      to_port          = 0
      protocol         = "icmp"
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr_blocks]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      description      = "ALL"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr_blocks]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
  tags = {
    "Name" = "${var.name}-sg"
  }
}


# 11_ec2

/*
resource "aws_ami" "amzn" {
  most_recent =

  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
      name = "virtualization-type"
      values = ["hvm"]
  }

  owners = ["amazon"]
}
*/

resource "aws_instance" "jinwoo-web" {
  # ami 는 리전마다 다름
  ami = "ami-04e8dfc09b22389ad"
  instance_type = "t2.micro"
  key_name = var.key
  availability_zone = "${var.region}${var.ava[0]}"
  private_ip = "10.0.0.11"
  subnet_id = aws_subnet.jinwoo-pub[0].id   #public_subnet a의 ID
  vpc_security_group_ids = [aws_security_group.jinwoo-sg.id]
  # user_data 수정시 인스턴스를 삭제하고 다시 만들어짐
  user_data = file("../01_test/install.sh")
  
}

resource "aws_eip" "jinwoo-web-ip" {
  vpc = true
  instance = aws_instance.jinwoo-web.id
  associate_with_private_ip = "10.0.0.11"
  depends_on = [
    aws_internet_gateway.jinwoo-ig
  ]
}

# 공인 ip 출력
# output "public_ip" {
#   value = aws_instance.jinwoo-web.public_ip
# }