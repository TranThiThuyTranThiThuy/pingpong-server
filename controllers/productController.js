const Product = require("../models/productModel");

exports.getTopSellingProducts = (req, res) => {
    const { category_id } = req.query;

    console.log("Controller - category_id (top-selling):", category_id);

    if (!category_id) {
        return res.status(400).json({ message: "Thiếu category_id" });
    }

    Product.getTopSellingProducts(category_id, (err, results) => {
        if (err) {
            console.error("❌ Lỗi truy vấn MySQL (top-selling):", err);
            return res.status(500).json({ message: "Lỗi server" });
        }

        if (!results || results.length === 0) {
            return res.json({ message: "Không có sản phẩm bán chạy nào!" });
        }

        const updatedResults = results.map(product => ({
            ...product,
            image_url: product.image_url
                ? `http://localhost:3000/images/${product.image_url}`
                : './assets/imgs/no-image.png'
        }));

        res.json(updatedResults);
    });
};

exports.getProductsByCategory = (req, res) => {
    const { category_id, type } = req.query;

    console.log("Controller - category_id:", category_id);
    console.log("Controller - type:", type);

    if (!category_id) {
        return res.status(400).json({ message: "Thiếu category_id" });
    }

    Product.getProductsByCategory(category_id, type, (err, results) => {
        if (err) {
            console.error("❌ Lỗi truy vấn MySQL:", err);
            return res.status(500).json({ message: "Lỗi server" });
        }

        if (!results || results.length === 0) {
            return res.json({ message: "Không có sản phẩm nào trong danh mục này!" });
        }

        const updatedResults = results.map(product => ({
            ...product,
            image_url: product.image_url
                ? `http://localhost:3000/images/${product.image_url}`
                : './assets/imgs/no-image.png'
        }));

        res.json(updatedResults);
    });
};

module.exports = exports;