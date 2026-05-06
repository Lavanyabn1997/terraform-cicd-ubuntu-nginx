#!/bin/bash

echo "Stopping existing container..."
docker stop nginx || true
docker rm nginx || true

echo "Pulling latest image..."
docker pull nginx

echo "Running new container..."
docker run -d --name nginx -p 80:80 nginx
