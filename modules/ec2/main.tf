resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  iam_instance_profile   = var.iam_profile

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "nginx-ubuntu"
  }
}
