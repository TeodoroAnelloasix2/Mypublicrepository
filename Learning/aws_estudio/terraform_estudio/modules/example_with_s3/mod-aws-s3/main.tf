resource "aws_s3_bucket" "s3_bkt" {
  count = 1
  bucket = "${var.bucket_name}-${count.index}"
}
