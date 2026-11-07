# 20 — Shareable Customer Statement Web Link (رابط كشف الحساب الإلكتروني)

**Phase:** 2 · **Tier:** Paid (Pro & Installments Pro) · **Depends on:** 02 Customers, 03 Transactions, 13 Cloud Sync, 16 Paywall

## User story
As a shop owner, I want to send my customer a secure, beautiful web link to their live account statement on WhatsApp instead of sending heavy PDF files, so they can review their purchases, payments, and remaining balance from any smartphone browser without asking me to re-send statements.

---

## 1. Architecture & Security Model

### Web Link Format
```
https://kashkool.app/s/{secure_token}
```
- Short, branded, mobile-friendly URL.
- `{secure_token}`: Cryptographically random 128-bit URL-safe token.

### Privacy & Law 151/2020 Compliance
> [!IMPORTANT]
> **Minimal Data Exposure**: The public statement page displays **ONLY** what the customer needs to verify their debt:
> - Shop Name & Shop Phone / WhatsApp.
> - Customer Name (as recorded by merchant).
> - Date of generation.
> - Chronological ledger table: Date · Note/Items · Debt ("عليه") · Payment ("دفع") · Balance.
> - Total remaining balance (large font).
> - Payment channels (InstaPay username, Vodafone Cash / Mobile Wallet number).
> - **ZERO Personal Identifiable Information (PII)**: The customer's phone number, national ID, address, and merchant's internal notes are **never** rendered on the public web view.

---

## 2. Data Model — `statement_links`
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 |
| shopId | text | FK → shops.id |
| customerId | text | FK → customers.id |
| token | text | Unique signed indexing token |
| expiresAt | datetime | UTC expiration (default 7 days or 30 days configurable) |
| isRevoked | bool | Default false; instant kill switch by merchant |
| viewCount | int | Running counter of link visits |
| lastViewedAt | datetime? | UTC timestamp of last visit |
| createdAt, updatedAt, deletedAt | datetime | UTC timestamps |

---

## 3. Merchant Workflow (In-App)
1. Merchant opens Customer Details screen.
2. Taps **"مشاركة رابط كشف الحساب"** (🔒 Pro badge).
3. Bottom sheet options:
   - Period: كل الحركات (All time) · الشهر الحالي (This month) · آخر 3 شهور (Last 3 months).
   - Validity: أسبوع (7 days) · شهر (30 days).
4. Tap **"نسخ ومشاركة عبر واتساب"**:
   - Edge Function generates token and stores snapshot in `statement_links`.
   - App opens WhatsApp with ready-made friendly message:
     ```
     السلام عليكم أ/ {customer_name} 👋
     معاك {shop_name}.
     تقدر تراجع كشف حسابك والمتبقي عبر الرابط المؤمن التالي:
     https://kashkool.app/s/{token}
     (الرابط متاح حتى {expiry_date})
     شكراً لتعاملك معانا 🙏
     ```
5. **Revocation & Management**:
   - In Customer Details → Links, merchant sees active links with view count.
   - Merchant can tap **"إلغاء الرابط" (Revoke)** anytime to immediately invalidate access.

---

## 4. Web View Delivery
- Hosted via Supabase Edge Function / Cloudflare Workers rendering lightweight SSR HTML/CSS (loads in < 500ms on 3G).
- Responsive mobile design, RTL Arabic Cairo font.
- Print / Download PDF button built into the web page.
- Direct "ادفع عبر إنستاباي" button (launches `instapay://` deep link if user has InstaPay app installed).
- When expired or revoked, displays a polite Egyptian message: *"عذراً، انتهت صلاحية هذا الرابط. يرجى التواصل مع المحل لتحديث كشف الحساب"*.

---

## Acceptance Criteria
- [ ] Link generation is instant (< 1 second) and copies directly to WhatsApp launcher.
- [ ] Statement web view renders correctly in mobile Safari and Chrome on Android.
- [ ] Customer phone number and national ID are never exposed in HTML or JSON.
- [ ] Revoked or expired links reject access cleanly.
- [ ] Pro tier entitlement enforced; Free users shown upgrade sheet.
