# Terraform module to create AWS s3 Bucket

module "s3" {
  source = "./mod-aws-s3"
  region = local.region
  bucket_name = "overwritten-default"
}

output "s3_bucket_id" {
  value = module.s3.s3_bucket_id
}
output "s3_bucket_arn" {
  value = module.s3.s3_bucket_arn
}