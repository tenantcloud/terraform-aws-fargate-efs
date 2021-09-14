resource "aws_lb" "main" {
  name            = "${var.project}-balancer"
  subnets         = var.subnets_public
  security_groups = [aws_security_group.lb.id]
  tags = {
    Name = "${var.project}-balancer"
  }
}

resource "aws_lb_target_group" "app" {
  name        = "${var.project}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "10"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
  tags = {
    Name = "${var.project}-target-group"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_lb_listener" "front_end_http" {
  load_balancer_arn = aws_lb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "front_end_https" {
  load_balancer_arn = aws_lb.main.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-2018-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.id
  }
}
