import { GoogleAuth } from 'google-auth-library';
import { config } from '../config.js';
import { HttpError } from '../utils/http.js';

let authClient;

async function getAuthClient() {
  if (!config.play.serviceAccountJson) {
    throw new HttpError(500, 'play_not_configured', 'GOOGLE_PLAY_SERVICE_ACCOUNT_JSON is not set on the server');
  }
  if (!authClient) {
    const auth = new GoogleAuth({
      credentials: JSON.parse(config.play.serviceAccountJson),
      scopes: ['https://www.googleapis.com/auth/androidpublisher'],
    });
    authClient = await auth.getClient();
  }
  return authClient;
}

/** Fetches a subscription purchase from the Google Play Developer API (subscriptionsv2). */
export async function fetchPlaySubscription(purchaseToken) {
  const client = await getAuthClient();
  const url =
    `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/${encodeURIComponent(config.play.packageName)}` +
    `/purchases/subscriptionsv2/tokens/${encodeURIComponent(purchaseToken)}`;
  try {
    const res = await client.request({ url });
    return res.data;
  } catch (err) {
    const status = err?.response?.status;
    if (status === 400 || status === 404 || status === 410) {
      throw new HttpError(400, 'invalid_purchase_token', 'Google Play does not recognise this purchase');
    }
    throw new HttpError(502, 'play_unavailable', 'Could not reach Google Play, try again');
  }
}

/** Converts Google's response into what we store. Pure function. */
export function mapPlaySubscription(data, productTiers = config.play.productTiers) {
  const items = Array.isArray(data?.lineItems) ? data.lineItems : [];
  let best = null;
  for (const item of items) {
    const exp = item.expiryTime ? Date.parse(item.expiryTime) : 0;
    if (!best || exp > best.exp) best = { productId: item.productId, exp };
  }
  return {
    state: data?.subscriptionState || 'SUBSCRIPTION_STATE_UNSPECIFIED',
    productId: best?.productId ?? null,
    tier: best ? productTiers[best.productId] ?? null : null,
    expiresAt: best?.exp ? new Date(best.exp) : null,
    linkedShopId: data?.externalAccountIdentifiers?.obfuscatedExternalAccountId ?? null,
    acknowledged: data?.acknowledgementState === 'ACKNOWLEDGEMENT_STATE_ACKNOWLEDGED',
  };
}
