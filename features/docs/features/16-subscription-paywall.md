# 16 — Subscription & Paywall (الاشتراكات وبوابة الدفع)

**Phase:** 2 · **Tier:** System Infrastructure · **Depends on:** Phase 1 complete, 13 Cloud Sync

## User story
As a growing shop owner, I want to upgrade to a paid plan seamlessly via Google Play to unlock multi-device cloud sync, employee permissions, and the full installments engine, with complete transparent pricing in Egyptian Pounds.

---

## 1. Unified Subscription Plans

| Plan | Price (EGP / month) | Core Features Included |
|---|---|---|
| **مجاني (Free)** | **0 ج.م** (دائمـاً) | Fully local offline ledger, customers, transactions, suppliers, cash drawer closing, basic PDF statements, home widget, 1 active installment trial plan. |
| **محترف (Pro)** | **79 ج.م** / شهر<br>*(أو 790 ج.م / سنة بتوفير شهرين)* | All Free features + Automatic PowerSync/Supabase cloud backup, real-time multi-device sync, employee permissions (15), shareable web statement links (20), removal of the growth footer (11), priority support. |
| **أقساط برو (Installments Pro)** | **149 ج.م** / شهر<br>*(أو 1,490 ج.م / سنة بتوفير شهرين)* | All Pro features + **Unlimited installment plans (14)**, schedule generator, contract & promissory note attachments, WhatsApp installment reminders, early settlement calculator, late fee tracking. |

> [!NOTE]
> *Prices listed above are initial calibrated placeholders and are remotely configurable via Supabase Edge Function `remote-config`.*

---

## 2. In-App Billing Engine

### Primary Channel: Google Play Billing
- Implemented via `in_app_purchase` Flutter package (Play Billing Library v6+).
- Handles subscriptions: monthly and yearly auto-renewing products.
- Server-side verification via Supabase Edge Function (`verify-play-purchase`) validating purchase tokens against Google Play Developer API.
- Entitlement records stored in `subscriptions` table in Supabase and cached locally in Drift.

> [!WARNING]
> **Google Play Policy Compliance for Egypt**:
> Google Play Developer Policy strictly mandates Google Play Billing for all digital features and cloud services unlocked within apps distributed on the Play Store. 
> **Any external payment gateways (e.g. Fawry, Vodafone Cash, Paymob, InstaPay) MUST NOT be introduced directly inside the Play Store build** without official enrollment in Google Play's alternative billing (User Choice Billing) program for Egypt, as direct external payment links violate Google Play policies and risk immediate account suspension.

---

## 3. Data Model — `subscriptions`
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 |
| shopId | text | FK → shops.id |
| plan | enum | `free` \| `pro` \| `installments_pro` |
| status | enum | `active` \| `in_grace` \| `cancelled` \| `expired` |
| source | enum | `google_play` \| `promo_code` \| `referral_reward` \| `admin_grant` |
| externalSubscriptionId | text? | Google Play purchase/subscription ID |
| currentPeriodStart | datetime | UTC |
| currentPeriodEnd | datetime | UTC |
| trialEnd | datetime? | 14-day free trial expiration |
| cancelAtPeriodEnd | bool | True if user cancelled subscription |
| createdAt, updatedAt, deletedAt | datetime | UTC timestamps |

---

## 4. Paywall UX & User Journey
- **Contextual Paywall**: Never shown as a blocking popup on app launch. Triggered only when the merchant taps a locked Pro/Installments feature:
  - Tapping "+ خطة قسط جديدة" when 1 active plan already exists.
  - Tapping "مزامنة سحابية" or "إضافة عامل".
  - Tapping "مشاركة رابط كشف الحساب".
- **Egyptian Shopkeeper Value Pitch**:
  - *"احمي كشكولك من الضياع أو تلف التليفون"*
  - *"تابع محلك وأنت في البيت من تليفونك"*
  - *"ظبط أقساطك واعرف ليك كام كل شهر بدقة"*
- **14-Day Free Trial**: 14-day trial for new accounts (no credit card required on local trial).
- **Grace Period**: 3 days offline grace period before locking cloud sync if internet is unavailable to verify renewal.
- **Restore Purchases**: Visible "استعادة الاشتراكات" button on the paywall screen.

---

## Acceptance Criteria
- [ ] Subscriptions test successfully in Google Play Internal Test Track.
- [ ] Pro and Installments Pro features unlock immediately upon purchase.
- [ ] Free local data is never deleted, locked, or degraded if a subscription expires or is cancelled (graceful downgrade to local Free tier).
- [ ] Offline entitlement caching allows uninterrupted app usage without network for up to 3 days.
- [ ] Restore purchases retrieves active entitlements on a new phone.
