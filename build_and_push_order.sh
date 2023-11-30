# Set nama repositori
REPO_NAME=kingxdeni

# Dapatkan Token dari file txt
GHCR_TOKEN=$(cat ../token.txt)

# Tentukan nama image
ORDER_IMAGE_NAME=order-service

# Perintah untuk build Docker image dari Dockerfile
docker build -t ghcr.io/$REPO_NAME/$ORDER_IMAGE_NAME:latest .

# Perintah untuk login ke GitHub Container Registry menggunakan Personal Access Token dari file
echo "$GHCR_TOKEN" | docker login ghcr.io -u $REPO_NAME --password-stdin

# Perintah untuk push image ke GitHub Packages
docker push ghcr.io/$REPO_NAME/$ORDER_IMAGE_NAME:latest
