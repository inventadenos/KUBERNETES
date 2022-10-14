#S3 BACKEND BLOCK
terraform {
  backend "s3" {
    bucket         = "ufuomaeleovie"
    key            = "terraform/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ufuomaddbtable"
  }
}
