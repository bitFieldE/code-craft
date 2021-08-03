resource "aws_nat_gateway" "codecraft-ngw" {
  allocation_id = aws_eip.codecraft-ngw-eip.id
  subnet_id     = aws_subnet.codecraft-frontend-1a.id
  depends_on    = [aws_internet_gateway.codecraft-igw]

  tags = {
    Name = "codecraft-ngw"
  }
}