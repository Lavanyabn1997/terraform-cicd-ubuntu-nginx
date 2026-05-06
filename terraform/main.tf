module "vpc" {
  source = "../modules/vpc"
}

module "ecr" {
  source    = "../modules/ecr"
  repo_name = var.repo_name
}

module "iam" {
  source = "../modules/iam"
}

module "ec2" {
  source        = "../modules/ec2"
  iam_profile   = module.iam.ec2_profile
}

module "codedeploy" {
  source = "../modules/codedeploy"
  role   = module.iam.codedeploy_role
  ec2_id = module.ec2.instance_id
}

module "codebuild" {
  source   = "../modules/codebuild"
  repo_url = module.ecr.repo_url
  role     = module.iam.codebuild_role
}

module "codepipeline" {
  source        = "../modules/codepipeline"
  github_owner  = var.github_owner
  github_repo   = var.github_repo
  github_token  = var.github_token

  build_project = module.codebuild.project_name
  deploy_app    = module.codedeploy.app_name
  deploy_group  = module.codedeploy.group_name
  pipeline_role = module.iam.codepipeline_role
}
