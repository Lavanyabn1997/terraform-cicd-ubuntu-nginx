variable "github_owner" {}
variable "github_repo" {}
variable "github_token" {}

variable "build_project" {}
variable "deploy_app" {}
variable "deploy_group" {}

variable "pipeline_role" {
  type = string
}

variable "s3_bucket" {
  default = "nginx-cicd-artifacts-bucket"
}
