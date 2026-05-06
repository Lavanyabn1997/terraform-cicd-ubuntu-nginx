output "ec2_profile" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "codebuild_role" {
  value = aws_iam_role.codebuild_role.arn
}

output "codedeploy_role" {
  value = aws_iam_role.codedeploy_role.arn
}

output "codepipeline_role" {
  value = aws_iam_role.codepipeline_role.arn
}
