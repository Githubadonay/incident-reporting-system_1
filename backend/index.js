//import packages using require 
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const PORT = 3000;

// In-memory array to hold reports during development
const reports = [];

app.use(cors());
app.use(bodyParser.json());
// pulls the post from reports 
app.post('/report', (req, res) => {
  console.log('Received report:', req.body);
  reports.push(req.body); //allows each imcoming report to be stored
  res.status(200).send({ message: 'Received' });
});

//fetch all reports and drops it to the report history 
app.get('/reports', (req, res) => {
  res.status(200).json(reports);
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
