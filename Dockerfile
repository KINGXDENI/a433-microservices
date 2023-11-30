# Gunakan runtime resmi Node.js sebagai image parent
FROM node:14

# Tetapkan direktori kerja di dalam kontainer
WORKDIR /app

# Salin package.json dan package-lock.json ke direktori kerja
COPY package*.json ./

# Install dependensi
RUN npm install

# Salin sisa kode aplikasi
COPY . .

# Ungkapkan port yang digunakan oleh aplikasi
EXPOSE 3000

# Perintah untuk menjalankan aplikasi
CMD ["npm", "start"]
