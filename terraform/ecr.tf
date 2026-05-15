### This file defines an AWS ECR repository for the demo application.###

resource "aws_ecr_repository" "demo_app" {
  name = "demo-app"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "demo-app"
  }
}