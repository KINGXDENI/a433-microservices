#!/bin/bash

# Token disimpan dalam file txt
TOKEN=$(cat ../token.txt)

# Perintah untuk build Docker image dari Dockerfile
docker build -t ghcr.io/kingxdeni/karsajobs:latest .

# Perintah untuk login ke GitHub Container Registry menggunakan Personal Access Token dari file
echo "$TOKEN" | docker login ghcr.io -u kingxdeni --password-stdin

# Perintah untuk push image ke GitHub Packages
docker push ghcr.io/kingxdeni/karsajobs:latest
