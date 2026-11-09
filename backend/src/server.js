// Local development server: `npm run dev` (reads .env).
import app from './app.js';

const port = Number(process.env.PORT) || 3000;
app.listen(port, () => {
  console.log(`Kashkool backend running on http://localhost:${port}`);
});
