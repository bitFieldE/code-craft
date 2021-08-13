resource "aws_cloudwatch_log_group" "codecraft-ecs-backend" {
  name              = "/ecs/backend"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "codecraft-ecs-frontend" {
  name              = "/ecs/frontend"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "codecraft-ecs-db-create" {
  name              = "/ecs/db-create"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "codecraft-ecs-db-migrate" {
  name              = "/ecs/db-migrate"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "codecraft-ecs-db-seed" {
  name              = "/ecs/db-seed"
  retention_in_days = 180
}