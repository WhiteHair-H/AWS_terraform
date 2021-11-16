# 12_alb
resource "aws_lb" "jinwoo-alb" {
  name = "${var.name}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.jinwoo-sg.id]
  subnets = [aws_subnet.jinwoo-pub[0].id,aws_subnet.jinwoo-pub[1].id]

  tags = {
    "Name" = "${var.name}-alb"
  }
}

# 13_lbtg
resource "aws_lb_target_group" "jinwoo-lbtg" {
  name = "tf-ip-lb-tg"
  port = var.port_http
  protocol = var.protocol_http
# target_type 은 기본으로 설정하기에 삭제
  vpc_id = aws_vpc.jinwoo_vpc.id

  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 5
    matcher = "200"
    path = "/health.html"
    port = "traffic-port"
    protocol = var.protocol_http
    timeout = 2
    unhealthy_threshold = 2
  }
}

# 14_ll
resource "aws_lb_listener" "jinwoo-ll" {
  load_balancer_arn = aws_lb.jinwoo-alb.arn
  port              = "${var.port_http}"
  protocol          = var.protocol_http

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jinwoo-lbtg.arn
  }
}

# 15_albtgatt
resource "aws_lb_target_group_attachment" "jinwoo-albtgatt" {
  target_group_arn = aws_lb_target_group.jinwoo-lbtg.arn
  target_id        = aws_instance.jinwoo-web.id
  port             = var.port_http

}

