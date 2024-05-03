terraform {
  backend "s3" {
    # bucket = "YOUR S3 BUCKET NAME"
    # key    = "alb/terraform.tfstate"
    # region = "YOUR S3 BUCKET REGION"
  }
}
