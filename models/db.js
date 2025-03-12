const mysql = require("mysql");

const db = mysql.createConnection({
    host: "localhost",
    user: "root", // Thay bằng user của bạn
    password: "", // Thay bằng mật khẩu của bạn
    database: "pingpong" // Thay bằng tên database của bạn
});

db.connect((err) => {
    if (err) {
        console.error("Lỗi kết nối DB: ", err);
        return;
    }
    console.log("✅ Kết nối DB thành công!");
});

module.exports = db;
