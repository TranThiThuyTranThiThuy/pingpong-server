const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const productRoutes = require('./routes/productsRoutes');
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const path = require('path');
dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());
// Định tuyến thư mục tĩnh
app.use('/component/navigation/pages', express.static(path.join(__dirname, 'component', 'navigation', 'pages')));
// Kiểm tra API
app.get('/', (req, res) => {
    res.send('🚀 Backend đang chạy!');
});
// Cung cấp thư mục tĩnh (images) để hình ảnh có thể truy cập qua HTTP
app.use('/assets', express.static(path.join(__dirname, 'component/assets')));

//app.use('/api', userRoutes);

// Định tuyến API
app.use('/products', productRoutes); // Gắn router vào đường dẫn /products
//login/reg
app.use('/auth', authRoutes);
// Lắng nghe cổng
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`✅ Server đang chạy tại http://localhost:${PORT}`);
});