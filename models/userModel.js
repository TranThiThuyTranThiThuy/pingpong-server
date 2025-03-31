// const db = require('./db');

// exports.getUserById = (userId, callback) => {
//     console.log("getUserById in userModel called with userId:", userId); // Thêm dòng này
//     db.query('SELECT * FROM users WHERE id = ?', [userId], (err, results) => {
//         if (err) {
//             console.error("Database error:", err);
//             return callback(err);
//         }
//         if (results.length === 0) {
//             console.log("User not found");
//             return callback(null, null);
//         }
//         console.log("User found:", results[0]); // Thêm dòng này
//         callback(null, results[0]);
//     });
// };