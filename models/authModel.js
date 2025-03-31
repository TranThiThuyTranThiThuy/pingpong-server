// models/authModel.js
const db = require('./db');
const bcrypt = require('bcryptjs');


module.exports = {
    register: (fullName, email, password, callback) => {
        bcrypt.hash(password, 10, (err, hashedPassword) => {
            if (err) {
                return callback(err, null);
            }
            const query = 'INSERT INTO users (full_name, email, password) VALUES (?, ?, ?)';
            db.query(query, [fullName, email, hashedPassword], (err, results) => {
                callback(err, results);
            });
        });
    },
    login: (email, password, callback) => {
        const query = 'SELECT * FROM users WHERE email = ?';
        db.query(query, [email], (err, results) => {
            if (err || results.length === 0) {
                return callback('Email hoặc mật khẩu không đúng!', null);
            }
            const user = results[0];
            bcrypt.compare(password, user.password, (err, isMatch) => {
                if (err || !isMatch) {
                    return callback('Email hoặc mật khẩu không đúng!', null);
                }
                callback(null, user);
            });
        });
    },

    getUserById: (userId, callback) => {
        const query = 'SELECT * FROM users WHERE user_id = ?';
        db.query(query, [userId], (err, results) => {
            if (err || results.length === 0) {
                return callback('Không tìm thấy người dùng!', null);
            }
            callback(null, results[0]);
        });
    }
};