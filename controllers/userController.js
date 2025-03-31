const jwtUtils = require('../utils/jwt');
const userModel = require('../models/userModel');

exports.getUserById = (req, res) => {
    console.log("getUserById called");
    console.log("req.params:", req.params);
    const userId = req.params.userId;

    userModel.getUserById(userId, (err, user) => {
        if (err || !user) {
            return res.status(404).json({ message: 'Người dùng không tồn tại' });
        }
        res.json(user);
    });
};