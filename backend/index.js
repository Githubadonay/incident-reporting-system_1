//import packages using require 
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { pool, init } = require('./database');

const app = express();
const PORT = 3000;

// store in memory using an array
const reports = [];

app.use(cors());
app.use(bodyParser.json());

init().catch(err => console.error('DB init error:', err));
// Create a new report
app.post('/report', async (req, res) => {
  const { description, location, date, image_url, anonymous } = req.body;
  try {
    const [result] = await pool.execute(
      `INSERT INTO reports
         (description, location, date, image_url, anonymous)
       VALUES (?, ?, ?, ?, ?)`,
      [
        description,
        location || null,
        date ? new Date(date) : new Date(),
        image_url || null,
        anonymous ? 1 : 0
      ]
    );

    const insertId = result.insertId;
    const [rows] = await pool.execute(
      'SELECT * FROM reports WHERE id = ?', [insertId]
    );
    const storedReport = rows[0];

    console.log('Stored report:', storedReport);
    res.status(200).json(storedReport);
  } catch (err) {
    console.error('DB insert error:', err);
    res.status(500).json({ error: 'Database error' });
  }
});

// Retrieve all reports
app.get('/reports', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT * FROM reports ORDER BY id DESC'
    );
    res.status(200).json(rows);
  } catch (err) {
    console.error('DB fetch error:', err);
    res.status(500).json({ error: 'Database error' });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
