# https://www.terraform.io/docs/language/settings/backends/s3.html#s3-state-storage
# interesting option about encryption maybe will utilize this in future
terraform {
  backend "s3" {
    bucket = "terraform-state-automatization"
    key    = "terraform.state"
    region = "us-east-2"
  }
}