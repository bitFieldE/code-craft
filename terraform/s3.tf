resource "aws_s3_bucket" "codecraft-s3-bucket" {
  bucket = "codecraft-s3-bucket-for-images"
  acl    = "public-read"

  tags = {
    Name = "codecraft-s3-bucket-for-images"
  }
}

resource "aws_s3_bucket" "codecraft-alb-log" {
  bucket = "artifact-terraform-for-codecraft"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}