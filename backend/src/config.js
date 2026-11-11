/**
 * Central configuration, read from environment variables.
 * On Vercel set these in Project → Settings → Environment Variables.
 */
const list = (v) => (v || '').split(',').map((s) => s.trim()).filter(Boolean);

const DEFAULT_PRODUCT_TIERS = {
  kashkool_pro_monthly: 'pro',
  kashkool_pro_yearly: 'pro',
  kashkool_installments_monthly: 'installments_pro',
  kashkool_installments_yearly: 'installments_pro',
};

function parseJson(value, fallback) {
  if (!value) return fallback;
  try {
    return JSON.parse(value);
  } catch {
    throw new Error('Invalid JSON in environment variable');
  }
}

export const config = {
  mongoUri: process.env.MONGODB_URI,
  dbName: process.env.MONGODB_DB || 'kashkool',

  jwtSecret: process.env.JWT_SECRET,
  accessTokenTtlSeconds: 60 * 60, // 1 hour
  refreshTokenTtlDays: 60,

  /** Comma-separated OAuth client IDs (Android + Web) accepted for Google Sign-In. */
  googleClientIds: list(process.env.GOOGLE_CLIENT_IDS),

  /** Local development only: never enabled on Vercel. */
  allowDevLogin: process.env.ALLOW_DEV_LOGIN === 'true' && !process.env.VERCEL,

  /** When false (default, for beta testing) every shop can sync without a subscription. */
  requireSubscription: process.env.REQUIRE_SUBSCRIPTION === 'true',

  /** Public base URL used in statement links, e.g. https://kashkool.vercel.app */
  publicBaseUrl: (process.env.PUBLIC_BASE_URL || '').replace(/\/+$/, ''),

  /** Vercel sends `Authorization: Bearer <CRON_SECRET>` to cron routes. */
  cronSecret: process.env.CRON_SECRET,

  play: {
    packageName: process.env.PLAY_PACKAGE_NAME || 'app.kashkool',
    serviceAccountJson: process.env.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON,
    pubsubToken: process.env.PLAY_PUBSUB_TOKEN,
    productTiers: parseJson(process.env.PLAY_PRODUCT_TIERS, DEFAULT_PRODUCT_TIERS),
  },

  /** Google emails allowed into the admin dashboard (/admin), comma-separated. */
  adminEmails: list(process.env.ADMIN_EMAILS).map((e) => e.toLowerCase()),
  // Shown on the public privacy and account-deletion pages (Google Play requires a contact).
  supportEmail: (process.env.SUPPORT_EMAIL || '').trim(),
  adminSessionHours: 8,

  /** Monthly prices (EGP) used to estimate revenue in the admin dashboard. */
  tierPrices: parseJson(process.env.TIER_PRICES_EGP, { pro: 79, installments_pro: 149 }),

  trialDays: 14,
  referrerRewardDays: 30,
  referredRewardDays: 14,
  maxReferralRewardsPerYear: 12,
};

export function assertConfig() {
  const missing = [];
  if (!config.mongoUri) missing.push('MONGODB_URI');
  if (!config.jwtSecret) missing.push('JWT_SECRET');
  if (missing.length) {
    throw new Error(`Missing required environment variables: ${missing.join(', ')}`);
  }
  if (config.jwtSecret.length < 32) {
    throw new Error('JWT_SECRET must be at least 32 characters');
  }
}
