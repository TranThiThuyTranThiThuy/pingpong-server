const express = require("express");
const router = express.Router();
const cartController = require("../controllers/cartController");

router.get("/:userId", cartController.getCartByUser);  // Lấy giỏ hàng của user
router.post("/", cartController.addToCart);            // Thêm sản phẩm vào giỏ hàng
router.put("/", cartController.updateCartItem);        // Cập nhật số lượng sản phẩm
router.delete("/:cartId", cartController.removeCartItem); // Xóa sản phẩm khỏi giỏ hàng
router.delete("/clear/:userId", cartController.clearCart); // Xóa toàn bộ giỏ hàng

module.exports = router;
