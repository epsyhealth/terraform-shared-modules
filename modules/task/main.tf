resource "aws_ecs_task_definition" "task" {
  family = var.name

  container_definitions = jsonencode([{
    cpu : var.cpu,
    image : var.image,
    memory : var.memory,
    name : var.name,
    mountPoints : [],
    volumesFrom : [],
    entryPoint : var.entrypoint,
    command : var.command,
    portMappings : [for port in var.ports : { containerPort : port.container, hostPort : port.host, protocol : port.proto }],
    essential : true,
    environment : var.environment,
    logConfiguration : {
      logDriver : "awslogs",
      options : {
        awslogs-group : var.awslogs_group,
        awslogs-stream-prefix : var.name,
        awslogs-region : var.awslogs_region
      }
    }
  }])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  tags                     = var.tags
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
}

resource "aws_cloudwatch_event_rule" "ecs_task_rule" {
  count               = var.schedule_expression != null ? 1 : 0
  name                = "${var.name}-rule"
  description         = "Runs ECS task"
  schedule_expression = var.schedule_expression
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["private-a"]
  }
}

data "aws_security_groups" "selected" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

resource "aws_cloudwatch_event_target" "ecs_task_target" {
  count     = var.schedule_expression != null ? 1 : 0
  target_id = "${var.name}-target"
  arn       = aws_ecs_task_definition.task.arn
  rule      = aws_cloudwatch_event_rule.ecs_task_rule[count.index].name
  role_arn  = var.task_role_arn

  ecs_target {
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.task.arn
    launch_type         = "FARGATE"
    platform_version    = "LATEST"

    network_configuration {
      subnets          = [data.aws_subnet.selected.id]
      security_groups  = data.aws_security_groups.selected.ids
      assign_public_ip = false
    }
  }

  input = jsonencode({
    "containerOverrides": [
      {
        "command": var.schedule_command
      }
    ]
  })

  depends_on = [
    aws_ecs_task_definition.task
  ]
}
