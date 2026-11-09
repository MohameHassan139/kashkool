import jwt from 'jsonwebtoken';
import { config } from '../config.js';
import { randomToken, sha256 } from '../utils/crypto.js';
import { unauthorized } from '../utils/http.js';

export function signAccessToken(userId) {
  return jwt.sign({ typ: 'access' }, config.jwtSecret, {
    subject: String(userId),
    expiresIn: config.accessTokenTtlSeconds,
    algorithm: 'HS256',
    issuer: 'kashkool',
  });
}

export function verifyAccessToken(token) {
  try {
    const payload = jwt.verify(token, config.jwtSecret, { algorithms: ['HS256'], issuer: 'kashkool' });
    if (payload.typ !== 'access' || !payload.sub) throw new Error('bad token type');
    return payload.sub;
  } catch {
    throw unauthorized('Invalid or expired access token');
  }
}

/** Creates a long-lived refresh token; only its hash is stored. */
export async function issueTokens(db, userId, deviceLabel) {
  const refreshToken = randomToken(48);
  const now = new Date();
  await db.collection('refresh_tokens').insertOne({
    tokenHash: sha256(refreshToken),
    userId,
    deviceLabel: deviceLabel || null,
    createdAt: now,
    expiresAt: new Date(now.getTime() + config.refreshTokenTtlDays * 86400_000),
  });
  return {
    accessToken: signAccessToken(userId),
    accessTokenExpiresIn: config.accessTokenTtlSeconds,
    refreshToken,
  };
}

/** Rotation: the used refresh token is deleted and a new pair is returned. */
export async function rotateRefreshToken(db, refreshToken) {
  const existing = await db.collection('refresh_tokens').findOneAndDelete({ tokenHash: sha256(refreshToken) });
  if (!existing || new Date(existing.expiresAt) <= new Date()) throw unauthorized('Invalid refresh token');
  const user = await db.collection('users').findOne({ id: existing.userId });
  if (!user || user.deletedAt) throw unauthorized('Account not found');
  return issueTokens(db, existing.userId, existing.deviceLabel);
}

export async function revokeRefreshToken(db, refreshToken) {
  await db.collection('refresh_tokens').deleteOne({ tokenHash: sha256(refreshToken) });
}
