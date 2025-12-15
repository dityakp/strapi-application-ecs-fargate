variable "aws_region" {
  default = "ap-south-1"
}

variable "image_uri" {
  description = "Full ECR image URI with tag"
  type        = string
}

variable "db_name" {
  default = "strapi_db"
}

variable "db_username" {
  default = "strapi"
}

variable "db_password" {
  sensitive = true
}

variable "app_keys" {}
variable "api_token_salt" {}
variable "admin_jwt_secret" {}
variable "transfer_token_salt" {}
variable "jwt_secret" {}
