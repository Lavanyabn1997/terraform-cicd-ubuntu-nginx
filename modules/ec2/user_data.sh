#!/bin/bash

set -e

echo "============================"
echo "Updating system"
echo "============================"
apt update -y
apt upgrade -y

echo "============================"
echo "Installing Docker"
echo "============================"
apt install -y docker.io

systemctl start docker
systemctl enable docker

# Allow ubuntu user to run docker without sudo
usermod -aG docker ubuntu

echo "============================"
echo "Installing AWS CLI"
echo "============================"
apt install -y awscli

echo "============================"
echo "Installing dependencies for CodeDeploy"
echo "============================"
apt install -y ruby wget

echo "============================"
echo "Installing CodeDeploy Agent"
echo "============================"
cd /home/ubuntu

wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install

chmod +x install
./install auto

systemctl start codedeploy-agent
systemctl enable codedeploy-agent

echo "============================"
echo "Setup complete"
echo "============================"
