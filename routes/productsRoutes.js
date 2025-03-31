const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');

console.log("productController in routes:", productController);

// Route cho sản phẩm bán chạy nhất
router.get('/top-selling', productController.getTopSellingProducts);

// Route cho sản phẩm theo danh mục
router.get('/by-category', productController.getProductsByCategory);

module.exports = router;