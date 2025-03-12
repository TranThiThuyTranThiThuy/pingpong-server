const cartModel = require("../models/cartModel");

// Lấy danh sách giỏ hàng theo user
exports.getCartByUser = (req, res) => {
    const userId = req.params.userId;

    cartModel.getCartByUser(userId, (err, results) => {
        if (err) {
            console.error("❌ Lỗi truy vấn MySQL:", err);
            return res.status(500).json({ message: "Lỗi server" });
        }
        res.json(results);
    });
};

// Thêm sản phẩm vào giỏ hàng
exports.addToCart = (req, res) => {
    const { userId, productId, quantity } = req.body;

    if (!userId || !productId || quantity <= 0) {
        return res.status(400).json({ message: "Dữ liệu không hợp lệ!" });
    }

    cartModel.addToCart(userId, productId, quantity, (err, results) => {
        if (err) {
            console.error("❌ Lỗi truy vấn MySQL:", err);
            return res.status(500).json({ message: "Lỗi server" });
        }
        res.json({ message: "Thêm vào giỏ hàng thành công!", results });
    });
};

// Cập nhật số lượng sản phẩm
exports.updateCartItem = (req, res) => {
    const { cartId, quantity } = req.body;

    if (!cartId || quantity <= 0) {
        return res.status(400).json({ message: "Dữ liệu không hợp lệ!" });
    }

    cartModel.updateCartItem(cartId, quantity, (err, results) => {
        if (err) {
            console.error("❌ Lỗi MySQL:", err);
            return res.status(500).json({ message: "Lỗi server" });
        }
        res.json({ message: "Cập nhật giỏ hàng thành công!", results });
    });
};

// Xóa sản phẩm khỏi giỏ hàng
exports.removeCartItem = (req, res) => {
    const cartId = req.params.cartId;

    cartModel.removeCartItem(cartId, (err, results) => {
        if (err) {
            console.error("❌ Lỗi MySQL:", err);
            return res.status(500).json({ message: "Lỗi server" });
        }
        res.json({ message: "Xóa sản phẩm khỏi giỏ hàng thành công!" });
    });
};

// Xóa toàn bộ giỏ hàng
exports.clearCart = (req, res) => {
    const userId = req.params.userId;

    cartModel.clearCart(userId, (err, results) => {
        if (err) {
            console.error("❌ Lỗi MySQL:", err);
            return res.status(500).json({ message: "Lỗi server" });
        }
        res.json({ message: "Xóa toàn bộ giỏ hàng thành công!" });
    });
};
