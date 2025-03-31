const jwt = require('jsonwebtoken');

module.exports = {
    generateToken: (payload) => {
        return jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1000h' }); // Sử dụng process.env.JWT_SECRET
    },
    verifyToken: (token) => {
        return jwt.verify(token, process.env.JWT_SECRET); // Sử dụng process.env.JWT_SECRET
    }
};