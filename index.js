// Menggunakan dotenv untuk mengatur konfigurasi lingkungan dari file .env
require('dotenv').config()

// Mengimpor express dan membuat instance aplikasi
const express = require("express");
const app = express();

// Menggunakan body-parser untuk menangani payload JSON dalam permintaan
const bp = require("body-parser");

// Mengimpor amqplib untuk berinteraksi dengan RabbitMQ
const amqp = require("amqplib");
const amqpServer = process.env.AMQP_URL; // Mengambil URL RabbitMQ dari variabel lingkungan
var channel, connection;

// Fungsi untuk terhubung ke RabbitMQ dan membuat saluran (channel)
connectToQueue();

async function connectToQueue() {
    try {
        connection = await amqp.connect(amqpServer);
        channel = await connection.createChannel();
        await channel.assertQueue("order");

        // Menangani pesan yang diterima dari antrian "order"
        channel.consume("order", data => {
            console.log(`Order received: ${Buffer.from(data.content)}`);
            console.log("** Will be shipped soon! **\n")

            // Mengakui (acknowledge) pesan setelah berhasil di-handle
            channel.ack(data);
        });
    } catch (ex) {
        console.error(ex);
    }
}

// Menjalankan server pada port yang ditentukan dalam variabel lingkungan
app.listen(process.env.PORT, () => {
    console.log(`Server running at ${process.env.PORT}`);
});
