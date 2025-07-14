const http = require('http');

const server = http.createServer((req, res) => {
  console.log(`[${new Date().toISOString()}] Received request: ${req.method} ${req.url}`);
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello from app.js!\n');
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`[${new Date().toISOString()}] Server is running on port ${PORT}`);
});
