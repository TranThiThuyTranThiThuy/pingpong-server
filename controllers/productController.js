const productModel = require("../models/productModel");

exports.getProductsByCategory = (req, res) => {
    const categoryId = parseInt(req.query.category, 10);

    if (isNaN(categoryId)) {
        return res.status(400).json({ message: "Danh mục không hợp lệ!" });
    }

    productModel.getProductsByCategory(categoryId, (err, results) => {
        if (err) {
            console.error("❌ Lỗi truy vấn MySQL:", err);
            return res.status(500).json({ message: "Lỗi server" });
        }

        if (!results || results.length === 0) {
            return res.json({ message: "Không có sản phẩm nào trong danh mục này!" });
        }

        const updatedResults = results.map(product => ({
            ...product,
            image_url: `http://localhost:3000/images/${product.image_url}`
        }));

        console.log("✅ Dữ liệu sản phẩm trả về:", updatedResults);
        res.json(updatedResults);
    });
};
