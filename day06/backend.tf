terraform {
  backend "s3" {
    bucket          = "my-tf-test-bucket-ns3e93ikei38"
    key             = "dev/terraform.tfstate"
    region          = "us-west-1"
    encrypt         = true
    use_lockfile    = true
  }
}