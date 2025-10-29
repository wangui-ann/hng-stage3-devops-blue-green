const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

let chaosMode = null;

app.use(express.json());

app.get('/version', (req, res) => {
  if (chaosMode === 'timeout') return; // simulate hang
  if (chaosMode === 'error') return res.status(500).send('Chaos error');

  res.set('X-App-Pool', process.env.APP_POOL || 'unknown');
  res.set('X-Release-Id', process.env.RELEASE_ID || 'dev');
  res.json({ version: process.env.RELEASE_ID || 'dev' });
});

app.get('/healthz', (req, res) => {
  if (chaosMode === 'timeout') return;
  if (chaosMode === 'error') return res.status(500).send('Unhealthy');
  res.send('OK');
});

app.post('/chaos/start', (req, res) => {
  chaosMode = req.query.mode || 'error';
  res.send(`Chaos started: ${chaosMode}`);
});

app.post('/chaos/stop', (req, res) => {
  chaosMode = null;
  res.send('Chaos stopped');
});

app.listen(port, () => {
  console.log(`Mock app running on port ${port}`);
});

