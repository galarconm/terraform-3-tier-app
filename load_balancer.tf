#LoadBalancer and TArgetGroup

resource "aws_lb" "app_lb" {
    name               = "app-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]

    idle_timeout = 60
    
}

resource "aws_lb_target_group" "app_tg" {
    name    = "MyTargetGroup"
    port    = 80
    protocol = "HTTP"
    vpc_id  = aws_vpc.main.id
    health_check {
        path                = "/"
        protocol            = "HTTP"
        matcher             ="200"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }

}