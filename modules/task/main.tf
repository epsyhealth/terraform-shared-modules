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
  network_mode             = var.network_mode
  cpu                      = var.cpu
  memory                   = var.memory
  tags                     = var.tags
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
}
