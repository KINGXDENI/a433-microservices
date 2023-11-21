# Perintah untuk membuat Docker image dari Dockerfile
docker build -t kingxdeni/item-app:v1 .

# Melihat daftar image di lokal
docker images

# Mengubah nama image agar sesuai dengan format GitHub Packages
docker tag kingxdeni/item-app:v1 docker.pkg.github.com/kingxdeni/a433-microservices/item-app:v1

# Login ke GitHub Packages
echo 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 | docker login docker.pkg.github.com -u kingxdeni --password-stdin

# Mengunggah image ke GitHub Packages
docker push docker.pkg.github.com/kingxdeni/a433-microservices/item-app:v1
