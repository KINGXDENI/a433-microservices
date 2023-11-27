#!/bin/bash

# Perintah untuk build Docker image dari Dockerfile
docker build -t ghcr.io/kingxdeni/karsajobs-ui:latest .

# Perintah untuk login ke GitHub Container Registry menggunakan Personal Access Token
echo "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" | docker login ghcr.io -u kingxdeni --password-stdin

# Perintah untuk push image ke GitHub Packages
docker push ghcr.io/kingxdeni/karsajobs-ui:latest
