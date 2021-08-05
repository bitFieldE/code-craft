resource "aws_eip" "codecraft-ngw-eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.codecraft-igw]

  tags = {
    Name = "codecraft-ngw-eip"
  }
}