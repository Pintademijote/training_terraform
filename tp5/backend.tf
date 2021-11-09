terraform {
  backend "s3" {
    bucket = "terraform-backend-pg"
    key    = "tfstate/state"
    region = "us-east-1"
  }
}