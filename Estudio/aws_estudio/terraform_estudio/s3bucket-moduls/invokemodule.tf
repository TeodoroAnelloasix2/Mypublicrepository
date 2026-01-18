
# To invoke a module 
module "mybucket"{
    source = "./s3"
    bucket_name = "unic-name-${random_string.randomized.result}"
}

# To use module's output
output "s3_arn" {
    value = module.mybucket.s3_bkt_arn
    # We must call an existing module's output
}


resource "random_string" "randomized" {
    length = 8
    special = false
    upper = false
    lower = true
    numeric = false
}


module "terraform_state_backend" {
    source = "cloudposse/tfstate-backend/aws"
    # Cloud Posse recommends pinning every module to a specific version
    version    = "0.38.1"
    namespace  = "backend_module"
    stage      = "dev"
    name       = "terraform"
    attributes = ["state"]

    terraform_backend_config_file_path = "."
    terraform_backend_config_file_name = "backend.tf"
    force_destroy                      = false
}