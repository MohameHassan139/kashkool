# 22 — Internal Operations & Admin Dashboard (لوحة الإدارة والعمليات)

**Phase:** 3 · **Tier:** Internal Ops Infrastructure · **Depends on:** 13 Cloud Sync, 16 Paywall, 19 Referral Program

## Goal
A secure, internal web dashboard for the Kashkool operations, support, and business teams to monitor shop adoption across Egyptian governorates, manage subscriptions, resolve support inquiries, audit referral qualification, and remotely toggle feature flags.

---

## 1. Access & Security
- Web app built with modern Flutter Web or Next.js, connected directly to Supabase with role-based admin auth.
- Multi-factor authentication (MFA) required for all internal staff.
- Admin action audit log: every staff change (e.g. granting trial days, revoking access) is logged with staff email and timestamp.

---

## 2. Core Dashboard Modules

### 🏪 1. المحلات والأنشطة (Shops & Merchants Directory)
- Searchable list by shop name, phone, referral `shopCode`, or ID.
- Breakdown by trade: بقالة (Grocery), موبايلات (Mobile), أجهزة كهربائية (Electronics), صيدليات (Pharmacies).
- Governorates & cities distribution map (Cairo, Giza, Alexandria, Delta, Upper Egypt).
- Device health: active sync devices, app version, last sync timestamp, offline duration.

### 💳 2. الاشتراكات والمدفوعات (Subscription Management)
- Live synchronization with Google Play Developer API (real-time developer notifications - RTDN).
- Status filters: تجريبي (Trial) · نشط (Active Pro / Installments Pro) · ملغي (Cancelled) · منتهي (Expired).
- Manual override tooling for customer support:
  - "منح فترة تجريبية إضافية" (+7 / +14 / +30 days).
  - "ترقية استثنائية" (Special complimentary grant for partners or beta testers).

### 🤝 3. الترشيحات ومكافحة الاحتيال (Referral Program & Fraud Audit)
- Real-time audit of qualified referrals (19):
  - Rule: Referred shop must record $\ge 10$ transactions across $\ge 3$ distinct calendar days.
- **Fraud detection indicators**:
  - Multiple shops created from the same device hardware ID or identical IP address subnet.
  - Rapid dummy transactions created within seconds of installation.
- One-click approve / reject referral reward payout (+30 days Pro).

### 🛠️ 4. الدعم الفني والمزامنة (Customer Support & Diagnostics)
- Merchant assistance view (read-only diagnostics):
  - Check PowerSync replication status and pending sync queue errors.
  - Verify subscription entitlement state.
  - Inspect last backup archive timestamp.
  - *Strict Privacy*: Customer names and transaction details are redacted unless explicitly authorized by the merchant for support sessions.

### 🚩 5. الإعدادات السحابية وأعلام الميزات (Remote Config & Feature Flags)
- Real-time configuration served via Supabase Edge Function `remote-config`:
  - `min_supported_version`: Force upgrade prompt for deprecated app versions.
  - `maintenance_banner`: Emergency notification ("جاري صيانة الخوادم...").
  - `pricing_tiers`: Dynamically update placeholder prices and promotional discounts without submitting a new app build to Google Play.
  - `feature_installments_enabled`: Global feature toggle.

---

## Acceptance Criteria
- [ ] Admin dashboard requires admin role credentials; unauthorized accounts are rejected.
- [ ] Support lookup by shop phone or code loads shop metadata in < 1 second.
- [ ] Manual subscription extension updates Supabase database and syncs to client device on next connection.
- [ ] Remote config changes reflect immediately on app client upon next startup.
