# 16 — Subscription & Paywall

**Phase:** 2 · **Tier:** — · **Depends on:** Phase 1

## Plans (initial, adjustable remotely)
| Plan | Price | Includes |
|---|---|---|
| Free | 0 | Everything local (Phase 1) |
| Pro | ~59–79 EGP/month or yearly with discount | Cloud sync & backup, installments, employees, statement link, remove footer, notebook import quota |

Prices fetched from store products — never hard-coded in UI.

## Technical
- Google Play Billing via `in_app_purchase` (or RevenueCat for simpler receipt handling).
- Server-side verification (Supabase Edge Function) → `subscriptions` table → entitlement.
- Entitlement cached locally; grace period 3 days offline.
- 14-day free trial of Pro.
- (Later) Local payment option: Fawry / Vodafone Cash / InstaPay via payment gateway (Paymob / Kashier) for users without cards.

## Paywall UX
- Shown only when user taps a Pro feature (🔒 badge), never as a blocking popup on launch.
- Explain value in shop-owner terms: "لو موبايلك ضاع، بياناتك مش هتضيع".
- Restore purchases button.

## Acceptance Criteria
- [ ] Purchase, renewal, cancellation, and restore work in Play test track.
- [ ] Pro features lock/unlock correctly; Free data never becomes inaccessible after cancellation.
- [ ] Trial starts once per account.
