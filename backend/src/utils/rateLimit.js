/**
 * Small in-memory rate limiter. On Vercel each warm instance has its own memory,
 * so this limits abuse per instance (good enough for login and public pages).
 */
export function rateLimit({ windowMs, max, keyFn = (req) => req.ip }) {
  const hits = new Map();
  return (req, res, next) => {
    const now = Date.now();
    const key = keyFn(req) || 'unknown';
    const entry = hits.get(key);
    if (!entry || entry.resetAt <= now) {
      hits.set(key, { count: 1, resetAt: now + windowMs });
    } else {
      entry.count += 1;
      if (entry.count > max) {
        res.setHeader('Retry-After', Math.ceil((entry.resetAt - now) / 1000));
        return res.status(429).json({ error: 'rate_limited', message: 'Too many requests, try again later' });
      }
    }
    if (hits.size > 10_000) {
      for (const [k, v] of hits) if (v.resetAt <= now) hits.delete(k);
    }
    next();
  };
}
