const express = require("express");
const router = express.Router();
const pool = require("../config/db");

// API lấy sản phẩm theo danh mục
router.get("/", (req, res) => {
    const categoryId = parseInt(req.query.category, 10);

    if (isNaN(categoryId)) {
        return res.status(400).json({ message: "Danh mục không hợp lệ!" });
    }

    const query = "SELECT * FROM products WHERE category_id = ?";

    pool.query(query, [categoryId], (err, results) => {
        if (err) {
            console.error("❌ Lỗi truy vấn MySQL:", err);
            return res.status(500).json({ message: "Lỗi server" });
        }

        if (!results || results.length === 0) {
            return res.json({ message: "Không có sản phẩm nào trong danh mục này!" });
        }

        // ✅ Định nghĩa updatedResults đúng chỗ
        const updatedResults = results.map(product => ({
            ...product,
            image_url: `http://localhost:3000/images/${product.image_url}`
        }));

        console.log("✅ Dữ liệu sản phẩm trả về:", updatedResults);
        res.json(updatedResults);
    });
});

module.exports = router;
