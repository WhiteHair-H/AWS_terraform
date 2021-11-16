# 16_ami
resource "aws_ami_from_instance" "jinwoo-ami" {
  name               = "jinwoo-ami"
  source_instance_id = aws_instance.jinwoo-web.id

  # 밑에 작업을 먼저 한뒤 위에 작업 실시(메타아규먼트)
  depends_on = [
    aws_instance.jinwoo-web
  ]
}

# 17_aslc
resource "aws_launch_configuration" "jinwoo-aslc" {
  name_prefix          = "${var.name}-web-"
  image_id             = aws_ami_from_instance.jinwoo-ami.id
  instance_type        = "t2.micro"
  iam_instance_profile = "admin-role"
  security_groups      = [aws_security_group.jinwoo-sg.id]
  key_name             = var.key
  # user_data = file("./install.sh")

  lifecycle {
    create_before_destroy = true
  }
}


# 18_aspg
resource "aws_placement_group" "jinwoo-pg" {
  name     = "${var.name}-pg"
  strategy = "cluster"
}

# 19_asgr
resource "aws_autoscaling_group" "jinwoo-asgr" {
  name                      = "jinwoo-terra-test"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 10
  health_check_type         = "EC2" # 인스턴스에 대해 체크
  desired_capacity          = 2     # 2개씩 증가
  force_delete              = true  # 강제삭제
  launch_configuration      = aws_launch_configuration.jinwoo-aslc.name
  vpc_zone_identifier       = [aws_subnet.jinwoo-pub[0].id, aws_subnet.jinwoo-pub[1].id]
}

# 20_asgalbatt
resource "aws_autoscaling_attachment" "jinwoo-asg" {
  autoscaling_group_name = aws_autoscaling_group.jinwoo-asgr.id
  alb_target_group_arn   = aws_lb_target_group.jinwoo-lbtg.arn

}
