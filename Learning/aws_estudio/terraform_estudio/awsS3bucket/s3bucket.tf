resource "aws_s3_bucket" "italianodev-s3bucket" {
    bucket = "itadev-${random_string.randomized.result}"
    tags = {
      "name" = "itadev-s3bucket"
      "enviromet"="development"
      "manteiner"="italianodev"
    }
}

resource "random_string" "randomized" {
    length = 8
    special = false
    upper = false
    lower = true
    numeric = false
}