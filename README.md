# alb
AWS Application Load Balancer for testing mTLS with open-source cloud Certificate Authority

* deploys AWS Application Load Balancer and EC2 instances using Terraform
* configure mTLS manually using the console as detailed in the [blog](https://medium.com)

## warning
This infrastructure is expensive to run - destroy immediately after use!

## requirements
You'll need to already have in your AWS account:
* Route53 public hosted zone
* S3 bucket for Terraform state

## Local Deployment - Terraform
* update `backend.tf` with details of your Terraform state S3 bucket
* duplicate `terraform-tfvars.example`, rename without the `.example` suffix
* enter values for:
    * fully qualified domain name for application
    * hosted zone ID
```
terraform init
terraform workspace new dev
terraform plan
terraform apply
```
Alternatively use `backend.tf` as is, and initialise with:
```
terraform init -backend-config=bucket={YOUR_TERRAFORM_STATE_BUCKET} -backend-config=key="alb/terraform.state" -backend-config=region={YOUR_TERRAFORM_STATE_REGION}
```