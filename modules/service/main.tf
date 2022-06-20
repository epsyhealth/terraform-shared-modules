data "aws_vpc" "main" {
  tags = {
    Name = "main"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.main.id
  tags = {
    Type = "private"
  }
}

resource "aws_ecs_service" "svc" {
  name            = var.name
  cluster         = var.cluster_id
  task_definition = var.task_definition
  launch_type     = "FARGATE"


  desired_count          = var.desired_count
  enable_execute_command = var.enable_execute_command

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  dynamic "load_balancer" {
    for_each = var.load_balancer

    content {
      target_group_arn = load_balancer.value["target_group_arn"]
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
    }
  }

  dynamic "service_registries" {
    for_each = var.service_registries

    content {
      registry_arn = service_registries.value["registry_arn"]
    }

  }

  network_configuration {
    subnets          = data.aws_subnet_ids.private.ids
    security_groups  = var.security_groups
    assign_public_ip = false
  }


  lifecycle {
    ignore_changes = [desired_count]
  }

}
