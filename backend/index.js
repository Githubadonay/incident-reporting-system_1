const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json());

app.post('/report', (req, res) => {
  console.log('Received report:', req.body);
  res.status(200).send({ message: "Received" });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
