#!/bin/bash

REGION="ap-south-1"
REPO_URI="$REPO_URI"

echo "Stopping container..."
docker stop nginx-app || true
docker rm nginx-app || true

echo "Login to ECR..."
aws ecr get-login-password --region $REGION \
| docker login --username AWS --password-stdin $REPO_URI

echo "Pulling image..."
docker pull $REPO_URI:latest

echo "Running container..."
docker run -d -p 80:80 --name nginx-app $REPO_URI:latest
