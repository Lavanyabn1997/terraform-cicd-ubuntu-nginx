resource "aws_codedeploy_app" "app" {
  name             = "nginx-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = "nginx-group"
  service_role_arn      = var.role

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "nginx-ubuntu"
    }
  }
}
