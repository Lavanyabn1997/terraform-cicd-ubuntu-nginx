variable "github_owner" {}
variable "github_repo" {}
variable "github_token" {}

variable "build_project" {}
variable "deploy_app" {}
variable "deploy_group" {}

variable "pipeline_role" {
  default = "arn:aws:iam::123456789012:role/codepipeline-role"
}

variable "s3_bucket" {
  default = "nginx-cicd-artifacts-bucket"
}
