terraform {
  backend "s3" {
    bucket         = "tf-states-learn-helisson"
    key            = "dev/main/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dev-main-terraform-locks"
    encrypt        = true
  }
}
