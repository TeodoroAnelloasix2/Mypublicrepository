variable "region" {
  description = "AWS region to use"
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "Default bucket name"
  type        = string
  default     = "my-bkt-example-module-codewar-2006-italianodevops"
}