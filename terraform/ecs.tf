/* クラスター */
resource "aws_ecs_cluster" "codecraft-ecs-cluster" {
  name = "codecraft-ecs-cluster"
}


/* フロント側 */

/* タスク定義 */
resource "aws_ecs_task_definition" "codecraft-frontend-task" {
  family                   = "codecraft-frontend-task"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/codecraft_frontend_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

/* サービス定義 */
resource "aws_ecs_service" "codecraft-frontend-ecs-service" {
  name                              = "codecraft-frontend-ecs-service"
  cluster                           = aws_ecs_cluster.codecraft-ecs-cluster.arn
  task_definition                   = "${aws_ecs_task_definition.codecraft-frontend-task.family}:${max("${aws_ecs_task_definition.codecraft-frontend-task.revision}", "${data.aws_ecs_task_definition.codecraft-frontend-task.revision}")}"
  desired_count                     = 1
  launch_type                       = "FARGATE"
  platform_version                  = "1.3.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.codecraft-ecs-sg.id
    ]
    subnets = [
      aws_subnet.codecraft-frontend-1a.id,
      aws_subnet.codecraft-frontend-1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.codecraft-alb-frontend-tg.arn
    container_name   = "frontend-container"
    container_port   = "80"
  }
}


/* バック側 */

/* タスク定義 */
resource "aws_ecs_task_definition" "codecraft-backend-task" {
  family                   = "codecraft-backend-task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/codecraft_backend_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

/* サービス定義 */
resource "aws_ecs_service" "codecraft-backend-ecs-service" {
  name                              = "codecraft-backend-ecs-service"
  cluster                           = aws_ecs_cluster.codecraft-ecs-cluster.arn
  task_definition                   = "${aws_ecs_task_definition.codecraft-backend-task.family}:${max("${aws_ecs_task_definition.codecraft-backend-task.revision}", "${data.aws_ecs_task_definition.codecraft-backend-task.revision}")}"
  desired_count                     = 1
  launch_type                       = "FARGATE"
  platform_version                  = "1.3.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.codecraft-ecs-sg.id
    ]
    subnets = [
      aws_subnet.codecraft-backend-1a.id,
      aws_subnet.codecraft-backend-1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.codecraft-alb-backend-tg.arn
    container_name   = "backend-container"
    container_port   = "3000"
  }
}

/* マイグレーション用タスク */
resource "aws_ecs_task_definition" "db-migrate" {
  family                   = "codecraft-db-migrate"
  container_definitions    = file("./tasks/codecraft_db_migrate_definition.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

/* ファミリーを指定するだけで、そのファミリーの最新のACTIVEリビジョンを見つけることができる */
data "aws_ecs_task_definition" "codecraft-frontend-task" {
  depends_on      = [aws_ecs_task_definition.codecraft-frontend-task]
  task_definition = aws_ecs_task_definition.codecraft-frontend-task.family
}
data "aws_ecs_task_definition" "codecraft-backend-task" {
  depends_on      = [aws_ecs_task_definition.codecraft-backend-task]
  task_definition = aws_ecs_task_definition.codecraft-backend-task.family
}


data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

module "ecs_task_execution_role" {
  source     = "./iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}
