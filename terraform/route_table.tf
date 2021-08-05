resource "aws_route_table" "codecraft-frontend-rtb" {
  vpc_id = aws_vpc.codecraft-vpc.id

  route {
    gateway_id = aws_internet_gateway.codecraft-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "codecraft-frontend-rtb"
  }
}
resource "aws_route_table" "codecraft-backend-rtb" {
  vpc_id = aws_vpc.codecraft-vpc.id

  route {
    gateway_id = aws_internet_gateway.codecraft-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "codecraft-backend-rtb"
  }
}


resource "aws_route_table_association" "codecraft-frontend-rtb-1a" {
  subnet_id      = aws_subnet.codecraft-frontend-1a.id
  route_table_id = aws_route_table.codecraft-frontend-rtb.id
}
resource "aws_route_table_association" "codecraft-frontend-rtb-1c" {
  subnet_id      = aws_subnet.codecraft-frontend-1c.id
  route_table_id = aws_route_table.codecraft-frontend-rtb.id
}
resource "aws_route_table_association" "codecraft-backend-rtb-1a" {
  subnet_id      = aws_subnet.codecraft-backend-1a.id
  route_table_id = aws_route_table.codecraft-backend-rtb.id
}
resource "aws_route_table_association" "codecraft-backend-rtb-1c" {
  subnet_id      = aws_subnet.codecraft-backend-1c.id
  route_table_id = aws_route_table.codecraft-backend-rtb.id
}