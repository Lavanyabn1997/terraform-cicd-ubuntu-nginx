#!/bin/bash

set -e

apt update -y
apt upgrade -y
apt install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu
apt install -y awscli
apt install -y ruby wget
cd /home/ubuntu
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
chmod +x install
./install auto
systemctl start codedeploy-agent
systemctl enable codedeploy-agent

