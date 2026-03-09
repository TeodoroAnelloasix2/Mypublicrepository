output "s3_bucket_id" {
  value = [for s3 in aws_s3_bucket.s3_bkt : s3.id]
}

output "s3_bucket_arn" {
  value = [for s3 in aws_s3_bucket.s3_bkt : s3.arn]

}