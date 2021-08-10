resource "aws_ecr_repository" "code-craft-frontend" {
  name                 = "code-craft-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
resource "aws_ecr_repository" "code-craft-backend" {
  name                 = "code-craft-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}