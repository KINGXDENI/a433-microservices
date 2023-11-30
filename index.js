// Menggunakan dotenv untuk mengatur konfigurasi lingkungan dari file .env
require('dotenv').config()

// Mengimpor express dan membuat instance aplikasi
const express = require("express");
const app = express();

// Menggunakan body-parser untuk menangani payload JSON dalam permintaan
const bp = require("body-parser");
app.use(bp.json());

// Mengimpor amqplib untuk berinteraksi dengan RabbitMQ
const amqp = require("amqplib");
const amqpServer = process.env.AMQP_URL; // Mengambil URL RabbitMQ dari variabel lingkungan
var channel, connection;

// Fungsi untuk terhubung ke RabbitMQ dan membuat saluran (channel)
connectToQueue();

async function connectToQueue() {
    connection = await amqp.connect(amqpServer);
    channel = await connection.createChannel();
    try {
        const queue = "order";
        await channel.assertQueue(queue);
        console.log("Connected to the queue!")
    } catch (ex) {
        console.error(ex);
    }
}

// Menangani permintaan POST ke endpoint /order
app.post("/order", (req, res) => {
    const {
        order
    } = req.body;
    createOrder(order);
    res.send(order);
});

// Fungsi untuk membuat pesanan dan mengirimkannya ke antrian RabbitMQ
const createOrder = async order => {
    const queue = "order";
    await channel.sendToQueue(queue, Buffer.from(JSON.stringify(order)));
    console.log("Order successfully created!")

    // Menangani sinyal SIGINT (Ctrl+C) untuk menutup saluran dan koneksi saat keluar
    process.once('SIGINT', async () => {
        console.log('got sigint, closing connection');
        await channel.close();
        await connection.close();
        process.exit(0);
    });
};

// Menjalankan server pada port yang ditentukan dalam variabel lingkungan
app.listen(process.env.PORT, () => {
    console.log(`Server running at ${process.env.PORT}`);
});
