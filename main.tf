terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.47.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

# Used to create cluster
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "3.2.0"
  # insert the 1 required variable here
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  tags = {
    Environment = "Development"
  }
}

# Containers
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "nginx:latest"
      cpu       = 0.5
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    },
    {
      name      = "second"
      image     = "nginx:latest"
      cpu       = 0.5
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}
