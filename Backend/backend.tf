terraform {
  backend "s3" {
    bucket         = "cloud-resume-challenge-tfstate"
    key            = "cloud-resume-challenge.tfstate"
    region         = "us-east-1"
    dynamodb_table = "cloud-resume-challenge-tflock"
  }
}
