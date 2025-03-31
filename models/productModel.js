const db = require("./db");

exports.getTopSellingProducts = (category_id, callback) => {
    console.log("category_id in model (top-selling):", category_id);

    // Check if category_id is valid (not undefined or null)
    if (!category_id) {
        const errorMessage = "Category ID is required and must be defined.";
        console.error(errorMessage);
        return callback(new Error(errorMessage), null);
    }

    const query = `
        SELECT p.product_id, p.product_name, p.price, p.image_url, 
               IFNULL(SUM(od.quantity), 0) AS total_sold
        FROM products p
        LEFT JOIN orderdetails od ON p.product_id = od.product_id
        WHERE p.category_id = ?
        GROUP BY p.product_id, p.product_name, p.price, p.image_url
        ORDER BY total_sold DESC
        LIMIT 10;
    `;

    db.query(query, [category_id], (err, results) => {
        if (err) {
            console.error("❌ Lỗi truy vấn MySQL (top-selling):", err);
            return callback(err, null);
        }
        callback(null, results);
    });
};

exports.getProductsByCategory = (category_id, type, callback) => {
    console.log("Model - category_id:", category_id);
    console.log("Model - type:", type);

    let query = `
        SELECT p.product_id, p.product_name, p.price, p.image_url, p.description, p.stock, p.type
        FROM products p
        WHERE p.category_id = ?
    `;

    const params = [category_id];

    if (type) {
        query += ` AND p.type = ?`;
        params.push(type);
    }

    query += ` ORDER BY p.product_name ASC;`;

    console.log("Model - query:", query);
    console.log("Model - params:", params);

    db.query(query, params, (err, results) => {
        if (err) {
            console.error("❌ Lỗi truy vấn MySQL:", err);
            return callback(err, null);
        }
        console.log("Model - results:", results);
        callback(null, results);
    });
};