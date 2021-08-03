resource "aws_internet_gateway" "codecraft-igw" {
  vpc_id = aws_vpc.codecraft-vpc.id

  tags = {
    Name = "codecraft-igw"
  }
}