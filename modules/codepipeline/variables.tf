variable "github_owner" {}
variable "github_repo" {}
variable "github_token" {}

variable "build_project" {}
variable "deploy_app" {}
variable "deploy_group" {}

variable "pipeline_role" {
  default = module.iam.codepipeline_role_arn
}

variable "s3_bucket" {
  default = "nginx-cicd-artifacts-bucket"
}
