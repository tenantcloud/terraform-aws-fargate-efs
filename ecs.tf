resource "aws_ecs_cluster" "main" {
  name = "${var.project}-cluster"
}

# data "template_file" "app" {
#   template = file("${path.module}/templates/ecs/app.json.tpl")

#   vars = {
#     app_image      = var.app_image
#     app_port       = var.app_port
#     fargate_cpu    = var.fargate_cpu
#     fargate_memory = var.fargate_memory
#     aws_region     = var.aws_region
#     project        = var.project
#   }
# }

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project}-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = <<DEFINITION
[
  {
    "name": "${project}-app",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/${project}-app",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ],
    "mountPoints": [
      {
        "readOnly": null,
        "containerPath": "/app/storage/tmp",
        "sourceVolume": "${project}-mp"
      }
    ]
  }
]
DEFINITION

  volume {
    name = join("-", [var.project, "mp"])
    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.main.id
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = var.access_point_id
      }
    }
  }
}

resource "aws_ecs_service" "main" {
  name             = "${var.project}-service"
  cluster          = aws_ecs_cluster.main.id
  task_definition  = aws_ecs_task_definition.app.arn
  desired_count    = var.app_count
  platform_version = "1.4.0"
  launch_type      = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.subnets_public
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.id
    container_name   = "${var.project}-app"
    container_port   = var.app_port
  }

  depends_on = [aws_lb_listener.front_end_https, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
