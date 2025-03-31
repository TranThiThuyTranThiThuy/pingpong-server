-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 13, 2025 lúc 11:22 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `pingpong`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `product_id`, `quantity`, `created_at`) VALUES
(1, 1, 2, 1, '2025-03-12 06:35:41'),
(2, 2, 3, 2, '2025-03-12 06:35:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Bộ vợt', 'Các loại bộ vợt cao cấp'),
(2, 'Cốt vợt', 'Cốt vợt phù hợp từng phong cách'),
(3, 'Mặt vợt', 'Mặt vợt hỗ trợ chơi bóng bàn'),
(4, 'Phụ kiện bóng bàn', 'Các phụ kiện đi kèm');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customers`
--

INSERT INTO `customers` (`customer_id`, `user_id`, `phone`, `address`) VALUES
(1, 1, '0987654321', 'Hà Nội'),
(2, 2, '0123456789', 'TP. HCM'),
(3, 3, '0987654321', 'Hà Nội'),
(4, 4, '0912345678', 'TP Hồ Chí Minh'),
(5, 5, '0321654987', 'Đà Nẵng'),
(6, 6, '0876543210', 'Hải Phòng'),
(7, 7, '0765432109', 'Cần Thơ');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orderdetails`
--

CREATE TABLE `orderdetails` (
  `orderdetail_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orderdetails`
--

INSERT INTO `orderdetails` (`orderdetail_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 18, 1200000.00),
(2, 1, 3, 16, 600000.00),
(3, 2, 2, 13, 900000.00),
(4, 2, 1, 4, 2400000.00),
(5, 3, 3, 32, 1800000.00),
(6, 4, 2, 21, 1800000.00),
(7, 5, 1, 3, 1200000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','shipped','delivered','cancelled') NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `total_price`, `status`, `order_date`) VALUES
(1, 1, 1800000.00, 'pending', '2025-03-12 06:35:41'),
(2, 2, 900000.00, 'shipped', '2025-03-12 06:35:41'),
(3, 3, 1800000.00, 'pending', '2025-03-12 06:35:41'),
(4, 4, 900000.00, 'shipped', '2025-03-12 06:35:41'),
(5, 5, 2500000.00, '', '2025-03-13 03:15:22'),
(6, 6, 3200000.00, 'delivered', '2025-03-14 01:20:55'),
(7, 7, 500000.00, 'cancelled', '2025-03-15 09:45:30');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `method` enum('credit_card','paypal','bank_transfer') NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `amount`, `method`, `payment_date`) VALUES
(1, 1, 1800000.00, 'credit_card', '2025-03-12 06:35:41'),
(2, 2, 900000.00, 'paypal', '2025-03-12 06:35:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `product_name`, `description`, `price`, `stock`, `image_url`, `type`, `category`) VALUES
(1, 1, 'Bộ vợt Double Fish', 'Bộ vợt cao cấp', 1200000.00, 10, './assets/images/bovot_doublefish.jpg', '', 'bo-vot'),
(2, 2, 'Cốt vợt Butterfly', 'Cốt vợt chất lượng cao', 900000.00, 15, 'butterfly.png', 'Butterfly', 'Cốt vợt'),
(3, 3, 'Mặt vợt DHS Hurricane 3', 'Mặt vợt chuyên nghiệp', 600000.00, 20, 'hurricane3.png', 'DHS', 'Mặt vợt'),
(4, 1, 'Bộ vợt Stiga Pro Carbon', 'Bộ vợt dành cho người chơi chuyên nghiệp', 1500000.00, 12, 'stiga_pro_carbon.png', 'Stiga', ''),
(5, 1, 'Bộ vợt Yasaka Ma Lin', 'Bộ vợt được thiết kế bởi Ma Lin', 1350000.00, 10, 'yasaka_ma_lin.png', 'Yasaka', ''),
(6, 2, 'Cốt vợt Xiom Vega Pro', 'Cốt vợt tốc độ cao, kiểm soát tốt', 1100000.00, 8, 'xiom_vega_pro.png', '', 'Cốt vợt'),
(7, 2, 'Cốt vợt Donic Ovtcharov', 'Cốt vợt của Ovtcharov - Đẳng cấp thế giới', 1250000.00, 7, 'donic_ovtcharov.png', 'Donic', 'Cốt vợt'),
(8, 2, 'Cốt vợt Andro Treiber K', 'Cốt vợt kiểm soát cao, tốc độ ổn định', 950000.00, 15, 'andro_treiber_k.png', 'Andro', 'Cốt vợt'),
(9, 3, 'Mặt vợt Tenergy 05', 'Mặt vợt bám xoáy mạnh', 750000.00, 18, 'tenergy05.png', '', 'Mặt vợt'),
(10, 3, 'Mặt vợt Rakza 7', 'Mặt vợt kiểm soát tốt, tốc độ ổn', 680000.00, 20, 'rakza7.png', '', 'Mặt vợt'),
(11, 3, 'Mặt vợt Tibhar Evolution MX-P', 'Mặt vợt tốc độ cao, phù hợp tấn công', 820000.00, 14, 'tibhar_mxp.png', '', 'Mặt vợt'),
(12, 1, 'Bộ vợt Joola Carbon Pro', 'Bộ vợt tích hợp công nghệ Carbon', 1400000.00, 9, 'joola_carbon_pro.png', '', ''),
(13, 2, 'Cốt vợt Stiga Clipper Wood', 'Cốt vợt gỗ 7 lớp, kiểm soát cao', 890000.00, 11, 'stiga_clipper_wood.png', 'Stiga', 'Cốt vợt'),
(14, 3, 'Mặt vợt DHS Gold Arc 8', 'Mặt vợt phù hợp cả công và thủ', 720000.00, 17, 'dhs_gold_arc8.png', 'DHS', 'Cốt vợt'),
(15, 2, 'Cốt vợt Nittaku Acoustic', 'Cốt vợt gỗ đặc biệt, cảm giác bóng tốt', 1280000.00, 6, 'nittaku_acoustic.png', 'Nittaku', ''),
(16, 1, 'Bộ vợt Butterfly Zhang Jike', 'Bộ vợt của Zhang Jike - Tốc độ, xoáy', 1650000.00, 5, 'zhang_jike.png', 'Butterfly', 'Mặt vợt'),
(17, 3, 'Mặt vợt Donic Bluefire M2', 'Mặt vợt linh hoạt, dễ điều khiển', 690000.00, 20, 'donic_bluefire_m2.png', 'Donic', 'Mặt vợt'),
(18, 2, 'Cốt vợt Yinhe Galaxy T-11', 'Cốt vợt nhẹ, kiểm soát tốt', 880000.00, 13, 'yinhe_galaxy_t11.png', '', 'Cốt vợt'),
(19, 3, 'Butterfly Rubber Cleaner', 'Dung dịch vệ sinh mặt vợt giúp bảo vệ và kéo dài tuổi thọ của mặt vợt.', 150000.00, 50, 'butterfly_cleaner.jpg', 'Vệ sinh mặt vợt', 'Phụ kiện'),
(20, 3, 'DHS Rubber Cleaner', 'Dung dịch vệ sinh mặt vợt chính hãng DHS, giúp làm sạch và bảo vệ mặt vợt.', 130000.00, 40, 'dhs_cleaner.jpg', 'Vệ sinh mặt vợt', 'Phụ kiện'),
(21, 3, 'Butterfly Edge Tape', 'Viền vợt Butterfly giúp bảo vệ cạnh vợt, hạn chế trầy xước.', 100000.00, 30, 'butterfly_edge_tape.jpg', 'Viền vợt', 'Phụ kiện'),
(22, 3, 'Yasaka Edge Tape', 'Viền vợt Yasaka chất lượng cao, giúp bảo vệ cốt vợt khỏi va đập.', 95000.00, 35, 'yasaka_edge_tape.jpg', 'Viền vợt', 'Phụ kiện'),
(23, 3, 'Butterfly Free Chack Glue', 'Keo dán vợt chính hãng Butterfly, độ bám dính tốt, dễ sử dụng.', 250000.00, 25, 'butterfly_glue.jpg', 'Keo dán', 'Phụ kiện'),
(24, 3, 'DHS No.15 Table Tennis Glue', 'Keo dán DHS chất lượng cao, dùng để dán mặt vợt chuyên nghiệp.', 220000.00, 20, 'dhs_glue.jpg', 'Keo dán', 'Phụ kiện');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `reviews`
--

INSERT INTO `reviews` (`review_id`, `user_id`, `product_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 1, 5, 'Rất tốt!', '2025-03-12 06:35:41'),
(2, 2, 2, 4, 'Chất lượng ổn', '2025-03-12 06:35:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('customer','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `role`) VALUES
(1, 'Nguyen Van A', 'a@example.com', 'password123', 'customer'),
(2, 'Tran Thi B', 'b@example.com', 'password123', 'customer'),
(3, 'Le Van C', 'c@example.com', 'password123', 'admin'),
(4, 'Pham Van D', 'd@example.com', 'password123', 'customer'),
(5, 'Hoang Thi E', 'e@example.com', 'password123', 'customer'),
(6, 'Dang Van F', 'f@example.com', 'password123', 'customer'),
(7, 'Bui Thi G', 'g@example.com', 'password123', 'customer');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Chỉ mục cho bảng `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`orderdetail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Chỉ mục cho bảng `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `orderdetail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
