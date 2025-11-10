terraform {
  backend "s3" {
    bucket                      = "terraform-state-dev"
    key                         = "monitoring/terraform.tfstate"
    region                      = "us-east-1"
    access_key                  = "test"
    secret_key                  = "test"
    use_path_style              = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true

    endpoints = {
      s3  = "http://localhost:4566"
      ec2 = "http://localhost:4566"
    }
  }
}
