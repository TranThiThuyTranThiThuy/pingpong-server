// controllers/authController.js
const authModel = require("../models/authModel");
const jwtUtils = require('../utils/jwt');

exports.register = (req, res) => {
    const { fullName, email, password } = req.body;

    authModel.register(fullName, email, password, (err, results) => {
        if (err) {
            console.error('Lỗi đăng ký:', err);
            return res.status(500).json({ message: 'Lỗi server' });
        }
        res.json({ message: 'Đăng ký thành công!' });
    });
};

exports.login = (req, res) => {
    const { email, password } = req.body;

    authModel.login(email, password, (err, user) => {
        if (err || !user) {
            return res.status(401).json({ message: 'Email hoặc mật khẩu không đúng!' });
        }

        const token = jwtUtils.generateToken({ userId: user.user_id, fullname: user.full_name, email: user.email });
        res.json({ token, user: { userId: user.user_id, fullname: user.full_name, email: user.email } }); // Trả về user_id trong response
    });
};