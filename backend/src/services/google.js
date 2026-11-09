import { OAuth2Client } from 'google-auth-library';
import { config } from '../config.js';
import { unauthorized, HttpError } from '../utils/http.js';

let client;

/** Verifies a Google Sign-In ID token from the app and returns the Google profile. */
export async function verifyGoogleIdToken(idToken) {
  if (config.googleClientIds.length === 0) {
    throw new HttpError(500, 'google_not_configured', 'GOOGLE_CLIENT_IDS is not set on the server');
  }
  client ??= new OAuth2Client();
  try {
    const ticket = await client.verifyIdToken({ idToken, audience: config.googleClientIds });
    const p = ticket.getPayload();
    if (!p?.sub || !p.email || p.email_verified === false) throw new Error('unverified');
    return { googleSub: p.sub, email: p.email.toLowerCase(), name: p.name || null, picture: p.picture || null };
  } catch {
    throw unauthorized('Invalid Google ID token');
  }
}
