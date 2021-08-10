resource "aws_ecr_repository" "codecraft-frontend" {
  name                 = "code-craft-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
resource "aws_ecr_repository" "codecraft-backend" {
  name                 = "code-craft-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}