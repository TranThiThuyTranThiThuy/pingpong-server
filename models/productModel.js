// productModel.js
const pool = require("../models/db");

// Hàm lấy sản phẩm bán chạy theo danh mục
exports.getBestSellingProductsByCategory = (categoryId, callback) => {
    const query = `
        SELECT p.product_id, p.product_name, p.price, p.image_url, 
               COALESCE(SUM(od.quantity), 0) AS total_sold
        FROM products p
        LEFT JOIN orderdetails od ON p.product_id = od.product_id
        WHERE p.category_id = ?
        GROUP BY p.product_id, p.product_name, p.price, p.image_url
        ORDER BY total_sold DESC
        LIMIT 6;
    `;
    
    pool.query(query, [categoryId], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        if (!results.length) {
            return callback("No products found or 'orderdetails' table might not exist.", null);
        }
        callback(null, results);
    });
};

// Nếu cần thêm hàm getProductsByCategory, có thể thêm như sau:
exports.getProductsByCategory = (categoryId, callback) => {
    const query = `
        SELECT product_id, product_name, price, image_url
        FROM products
        WHERE category_id = ?;
    `;
    
    pool.query(query, [categoryId], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        if (!results.length) {
            return callback("No products found in this category.", null);
        }
        callback(null, results);
    });
};
