resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = "ami-050499786ebf55a6a" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name
  network_interfaces {
    security_groups = [aws_security_group.ec2_sg.id]
    associate_public_ip_address = true
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<html><h1>Hello World!</h1></html>" > /var/www/html/index.html
              EOF
  )
}

resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  target_group_arns    = [aws_lb_target_group.app_tg.arn]

  tag {
    key                 = "Name"
    value               = "WebServer"
    propagate_at_launch = true
  }
}