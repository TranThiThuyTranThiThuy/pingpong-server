const pool = require("../models/db");

// Lấy giỏ hàng theo user_id
exports.getCartByUser = (userId, callback) => {
    const query = `
        SELECT c.id, c.user_id, c.product_id, c.quantity, p.name, p.price, p.image_url 
        FROM cart c 
        JOIN products p ON c.product_id = p.id
        WHERE c.user_id = ?
    `;
    pool.query(query, [userId], (err, results) => {
        if (err) return callback(err, null);
        callback(null, results);
    });
};

// Thêm sản phẩm vào giỏ hàng
exports.addToCart = (userId, productId, quantity, callback) => {
    const query = `
        INSERT INTO cart (user_id, product_id, quantity)
        VALUES (?, ?, ?)
        ON DUPLICATE KEY UPDATE quantity = quantity + ?
    `;
    pool.query(query, [userId, productId, quantity, quantity], (err, results) => {
        if (err) return callback(err, null);
        callback(null, results);
    });
};

// Cập nhật số lượng sản phẩm trong giỏ hàng
exports.updateCartItem = (cartId, quantity, callback) => {
    const query = "UPDATE cart SET quantity = ? WHERE id = ?";
    pool.query(query, [quantity, cartId], (err, results) => {
        if (err) return callback(err, null);
        callback(null, results);
    });
};

// Xóa sản phẩm khỏi giỏ hàng
exports.removeCartItem = (cartId, callback) => {
    const query = "DELETE FROM cart WHERE id = ?";
    pool.query(query, [cartId], (err, results) => {
        if (err) return callback(err, null);
        callback(null, results);
    });
};

// Xóa toàn bộ giỏ hàng của người dùng
exports.clearCart = (userId, callback) => {
    const query = "DELETE FROM cart WHERE user_id = ?";
    pool.query(query, [userId], (err, results) => {
        if (err) return callback(err, null);
        callback(null, results);
    });
};
