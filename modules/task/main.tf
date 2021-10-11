resource "aws_ecs_task_definition" "task" {
  family = var.name

  container_definitions = jsonencode([
    {
      cpu : var.cpu,
      image : var.image,
      memory : var.memory,
      name : var.name,
      mountPoints : [],
      volumesFrom : [],
      entryPoint : var.entrypoint,
      command : var.command,
      portMappings : [
      for port in var.ports : {
        containerPort : port.container, hostPort : port.host, protocol : port.proto
      }
      ],
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
    }
  ])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  tags                     = var.tags
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
}

data "aws_ecs_cluster" "main" {
  cluster_name = "main"
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

module "scheduled_task" {
  source                                      = "cn-terraform/ecs-fargate-scheduled-task/aws"
  count                                       = var.schedule_expression != null ? 1 : 0
  ecs_cluster_arn                             = data.aws_ecs_cluster.main.arn
  event_rule_schedule_expression              = var.schedule_expression
  ecs_execution_task_role_arn                 = var.execution_role_arn
  event_rule_name                             = "${var.name}-rule"
  event_target_ecs_target_subnets             = [data.aws_subnet.selected.id]
  event_target_ecs_target_security_groups     = data.aws_security_groups.selected.ids
  event_target_ecs_target_task_definition_arn = aws_ecs_task_definition.task.arn
  name_prefix                                 = var.name
  event_target_input                          = jsonencode({
    "containerOverrides" : [
      {
        "command" : var.schedule_command
      }
    ]
  })

  depends_on = [
    aws_ecs_task_definition.task
  ]
}
