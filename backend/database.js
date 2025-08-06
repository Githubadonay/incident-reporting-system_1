const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'Rainbow@2002',
  database: 'SIRS_db',
  waitForConnections: true,
  connectionLimit: 10,
});

async function init() {
  await pool.query(
    `CREATE TABLE IF NOT EXISTS reports (
      id INT AUTO_INCREMENT PRIMARY KEY,
      description TEXT NOT NULL,
      location VARCHAR(50),
      date DATETIME NOT NULL,
      image_url VARCHAR(255),
      anonymous BOOLEAN NOT NULL
    )`
  );// create a BLOB later for img
}

module.exports = { pool, init };
