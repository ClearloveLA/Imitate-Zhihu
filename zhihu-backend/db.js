// db.js
const mysql = require('mysql2');

// 创建一个连接池
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '123456',
  database: 'zhihu',
});

const db = pool.promise();
module.exports = db;
