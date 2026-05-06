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

  stage {
    name = "Source"

    action {
      name             = "GitHub"
      category         = "Source"
      provider         = "GitHub"
      owner            = "ThirdParty"

      output_artifacts = ["source"]

      configuration = {
        Owner      = var.github_owner
        Repo       = var.github_repo
        OAuthToken = var.github_token
        Branch     = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      input_artifacts = ["source"]

      configuration = {
        ProjectName = var.build_project
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      provider        = "CodeDeploy"

      input_artifacts = ["source"]

      configuration = {
        ApplicationName     = var.deploy_app
        DeploymentGroupName = var.deploy_group
      }
    }
  }
}
