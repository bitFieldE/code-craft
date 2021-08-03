resource "aws_subnet" "codecraft-frontend-1a" {
  vpc_id                  = aws_vpc.codecraft-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "codecraft-frontend-1a"
  }
}
resource "aws_subnet" "codecraft-frontend-1c" {
  vpc_id                  = aws_vpc.codecraft-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "codecraft-frontend-1c"
  }
}
resource "aws_subnet" "codecraft-backend-1a" {
  vpc_id                  = aws_vpc.codecraft-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "codecraft-backend-1a"
  }
}
resource "aws_subnet" "codecraft-backend-1c" {
  vpc_id                  = aws_vpc.codecraft-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "codecraft-backend-1c"
  }
}

resource "aws_db_subnet_group" "codecraft-rds-subnet-group" {
  name        = "codecraft-rds-subnet-group"
  description = "rds subnet for codecraft"
  subnet_ids  = [aws_subnet.codecraft-backend-1a.id, aws_subnet.codecraft-backend-1c.id]
}
