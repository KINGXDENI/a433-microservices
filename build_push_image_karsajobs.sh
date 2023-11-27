#!/bin/bash

# Perintah untuk build Docker image dari Dockerfile
docker build -t ghcr.io/kingxdeni/karsajobs:latest .

# Perintah untuk login ke GitHub Container Registry menggunakan Personal Access Token
echo "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" | docker login ghcr.io -u kingxdeni --password-stdin

# Perintah untuk push image ke GitHub Packages
docker push ghcr.io/kingxdeni/karsajobs:latest
