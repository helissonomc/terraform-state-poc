terraform {
  backend "s3" {
    bucket         = "tf-states-learn-helisson"
    key            = "dev/secondary/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dev-secondary-terraform-locks"
    encrypt        = true
  }
}
