import express from 'express';
import helmet from 'helmet';
import { adminRouter } from './routes/admin.js';
import { authRouter } from './routes/auth.js';
import { miscRouter } from './routes/misc.js';
import { shopsRouter } from './routes/shops.js';
import { statementLinksRouter } from './routes/statementLinks.js';
import { subscriptionsRouter } from './routes/subscriptions.js';
import { syncRouter } from './routes/sync.js';
import { HttpError } from './utils/http.js';

export function createApp() {
  const app = express();
  app.disable('x-powered-by');
  app.set('trust proxy', 1); // Vercel sits in front of the app
  app.use(helmet());
  app.use(express.json({ limit: '2mb' }));

  app.use(miscRouter);
  app.use(authRouter);
  app.use(shopsRouter);
  app.use(syncRouter);
  app.use(statementLinksRouter);
  app.use(subscriptionsRouter);
  app.use(adminRouter);

  app.use((req, res) => res.status(404).json({ error: 'not_found', message: 'Route not found' }));

  // eslint-disable-next-line no-unused-vars
  app.use((err, req, res, next) => {
    if (err instanceof HttpError) {
      return res.status(err.status).json({ error: err.code, message: err.message, ...(err.details ? { details: err.details } : {}) });
    }
    if (err?.type === 'entity.parse.failed') {
      return res.status(400).json({ error: 'invalid_json', message: 'Request body is not valid JSON' });
    }
    if (err?.type === 'entity.too.large') {
      return res.status(413).json({ error: 'payload_too_large', message: 'Request body is too large' });
    }
    if (err?.code === 11000) {
      return res.status(409).json({ error: 'duplicate', message: 'This record already exists' });
    }
    console.error('[unhandled]', req.method, req.path, err?.name, err?.message);
    res.status(500).json({ error: 'internal_error', message: 'Something went wrong' });
  });

  return app;
}

export default createApp();
