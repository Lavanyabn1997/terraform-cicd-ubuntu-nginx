#!/bin/bash
docker stop nginx || true
docker rm nginx || true
docker pull nginx
docker run -d --name nginx -p 80:80 nginx
