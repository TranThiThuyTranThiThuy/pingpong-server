const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const db = require('./models/db'); // Kết nối MySQL
const productRoutes = require('./routes/productsRoutes'); // Import API sản phẩm
const cartRoutes = require("./routes/cartRoutes");

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// Kiểm tra API
app.get('/', (req, res) => {
    res.send('🚀 Backend đang chạy!');
});

// Sử dụng routes từ products.js
app.use('/api/products', productRoutes);
app.use("/api/cart", cartRoutes);

// Lắng nghe trên cổng
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`✅ Server đang chạy tại http://localhost:${PORT}`);
});
