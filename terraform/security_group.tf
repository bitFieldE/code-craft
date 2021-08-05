/* security group for RDS */
resource "aws_security_group" "codecraft-rds-sg" {
  description = "RDS security group for codecraft"
  name        = "codecraft-rds-sg"
  vpc_id      = aws_vpc.codecraft-vpc.id
}

/* security group for ALB */
resource "aws_security_group" "codecraft-alb-sg" {
  description = "ALB security group for codecraft"
  name        = "codecraft-alb-sg"
  vpc_id      = aws_vpc.codecraft-vpc.id
}

/* security group for ECS */
resource "aws_security_group" "codecraft-ecs-sg" {
  description = "ECS security group for codecraft"
  name        = "codecraft-ecs-sg"
  vpc_id      = aws_vpc.codecraft-vpc.id
}