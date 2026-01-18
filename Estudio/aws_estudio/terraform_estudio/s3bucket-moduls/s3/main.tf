resource "aws_s3_bucket" "italianodev-s3bucket" {
    bucket = var.bucket_name
    tags = {
      "name" = "itadev-s3bucket"
      "enviromet"="development"
      "manteiner"="italianodev"
    }
}
