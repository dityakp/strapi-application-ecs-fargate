terraform {
  backend "s3" {
    bucket         = "strapi-terraform-state-aditya"
    key            = "task7/terraform.tfstate"
    region         = "ap-south-1"
    
    encrypt        = true
  }
}
