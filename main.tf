terraform {
  backend "s3" {
    bucket = "tf-state777"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    
  }
}