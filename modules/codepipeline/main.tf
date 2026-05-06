resource "aws_s3_bucket" "artifacts" {
  bucket = var.s3_bucket
}

resource "aws_codepipeline" "pipeline" {
  name     = "nginx-pipeline"
  role_arn = var.pipeline_role

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"
  }

  # ================= SOURCE =================
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]

      configuration = {
        Owner      = var.github_owner
        Repo       = var.github_repo
        Branch     = "main"
        OAuthToken = var.github_token
      }
    }
  }

  # ================= BUILD =================
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = var.build_project
      }
    }
  }

  # ================= DEPLOY =================
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ApplicationName     = var.deploy_app
        DeploymentGroupName = var.deploy_group
      }
    }
  }
}
