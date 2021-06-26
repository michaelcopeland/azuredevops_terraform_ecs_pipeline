terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

#resource "aws_instance" "app_server" {
#  ami           = "ami-830c94e3"
#  instance_type = "t2.micro"
#
#  tags = {
#    Name = "ExampleAppServerInstance"
#  }
#}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
resource "aws_ecs_service" "mongo" {
  name            = "mongodb"
  cluster         = 'arn:aws:ecs:us-east-1:118985243001:cluster/terraform-ecs-pipeline-test'
  task_definition = 'arn:aws:ecs:us-east-1:118985243001:task-definition/terraform-ecs-pipeline-test:1'
  desired_count   = 3
  iam_role        = 'arn:aws:iam::118985243001:role/terraform-ecs-pipeline-test'
  depends_on      = ['AmazonECSTaskExecutionRolePolicy', 'AmazonEKSFargatePodExecutionRolePolicy']

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

#  load_balancer {
#    target_group_arn = aws_lb_target_group.foo.arn
#    container_name   = "mongo"
#    container_port   = 8080
#  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1]"
  }
}
