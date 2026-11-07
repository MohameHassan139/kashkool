# 13 — Cloud Sync & Multi-Device Accounts (PowerSync + Supabase)

**Phase:** 2 · **Tier:** Paid (Pro & Installments Pro) · **Depends on:** Phase 1 complete, 16 Subscription Paywall

## User story
As a shop owner, I want my shop ledger automatically backed up to the cloud and synced in real-time across multiple devices (my phone, my tablet, my cashier's phone) without data conflicts, even when internet connection drops frequently.

---

## 1. Cloud Architecture & Infrastructure

### Cloud Provider & Server Region
- **Supabase**: Hosted PostgreSQL 15+, Supabase Auth, Supabase Storage, and Deno Edge Functions.
- **Server Region**: **Frankfurt, Germany (`eu-central-1`)** — selected specifically for Egyptian connectivity to provide the lowest ping and round-trip latency (~50–70 ms) compared to US regions.

### Sync Engine: PowerSync
- **Why PowerSync**:
  Instead of hand-rolling custom HTTP diffing and last-write-wins endpoints, we use **PowerSync** (`powersync` Flutter SDK).
  - PowerSync maintains a local SQLite database that synchronizes continuously with Supabase Postgres.
  - Automatically handles offline queuing, intermittent 2G/3G connectivity in Egyptian rural shops, delta synchronization, and background reconnects.
  - Seamlessly integrates with Drift as the local query layer.

---

## 2. Authentication Strategy

### Phase 2 Launch: Google Sign-In (الخيار الرئيسي الفوري)
- **1-Tap Google Sign-In** via `google_sign_in` and Supabase Native OAuth.
- **Why Google First**:
  - Almost 100% of Android phone owners in Egypt have an active Google Play / Gmail account on their device.
  - Zero SMS delivery failures (SMS OTP in Egypt suffers from severe telecom filtering and costs ~0.05 USD per message).
  - Instant, zero-friction 1-tap sign-in and backup activation.

### Phase 2 Extended: Phone OTP (تسجيل الدخول برقم الهاتف لاحقاً)
- Phone OTP via SMS will be added as a secondary alternative for merchants without Google accounts, configured via Egyptian SMS gateways or Twilio once traffic justifies gateway costs.

---

## 3. Row Level Security (RLS) Strategy

Every table in Supabase has RLS enabled (`ALTER TABLE ... ENABLE ROW LEVEL SECURITY;`).
Tenancy is strictly partitioned by `shopId` through the `shop_members` association:

```sql
-- Helper function to retrieve all active shops the authenticated user belongs to
CREATE OR REPLACE FUNCTION auth.get_user_shops() 
RETURNS SETOF uuid AS $$
  SELECT shop_id FROM public.shop_members 
  WHERE user_id = auth.uid() AND active = true;
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- Example RLS Policy for customers
CREATE POLICY "Users can access customers of their shop"
ON public.customers
FOR ALL
USING (shop_id IN (SELECT auth.get_user_shops()))
WITH CHECK (shop_id IN (SELECT auth.get_user_shops()));
```

---

## 4. PowerSync Sync Rules & Partitioning
PowerSync sync rules partition data streams by shop ID:

```yaml
# powersync.yaml
bucket_definitions:
  shop_data:
    parameters: [shop_id]
    data:
      - SELECT * FROM customers WHERE shop_id = request.parameters.shop_id
      - SELECT * FROM transactions WHERE shop_id = request.parameters.shop_id
      - SELECT * FROM installment_plans WHERE shop_id = request.parameters.shop_id
      - SELECT * FROM installments WHERE shop_id = request.parameters.shop_id
      - SELECT * FROM cash_days WHERE shop_id = request.parameters.shop_id
      - SELECT * FROM expenses WHERE shop_id = request.parameters.shop_id
      - SELECT * FROM suppliers WHERE shop_id = request.parameters.shop_id
```

---

## 5. Sync Rules & Data Integrity
1. **Append-Only Transactions**: Financial transactions are append-only. Edits insert a new row and soft-delete the previous one (`deletedAt = now()`), ensuring concurrent offline edits from two cashier phones never overwrite each other.
2. **Derived Values Never Synced**:
   - Customer balances, supplier balances, and cash drawer differences are **never synced**. Each device recalculates derived values locally from synced transactions.
3. **Photos & Attachments**:
   - Stored in Supabase Storage buckets: `receipts` and `contracts`.
   - Uploaded in background when Wi-Fi is available, or cellular data if user enables it.
   - Thumbnails generated client-side for rapid rendering.

---

## 6. First-Time Enable / Cloud Migration
1. Free user on local Drift DB subscribes to Pro.
2. User signs in with Google.
3. App calls Supabase RPC `init_shop_account(local_shop_id, shop_name)`.
4. PowerSync client is initialized and migrates all existing local records (`shopId`, `deviceId`, `createdBy`) to Supabase Postgres.
5. All future writes flow through PowerSync offline-first queue.

---

## Acceptance Criteria
- [ ] PowerSync replicates Postgres data into local Drift SQLCipher DB and vice versa.
- [ ] Google Sign-In works in 1-tap; session tokens refresh automatically.
- [ ] RLS tests verify User A cannot query, read, or write to Shop B under any API call.
- [ ] Offline edits created without internet queue locally and sync automatically when internet is restored.
- [ ] Photos upload to Supabase Storage with signed upload URLs and sync local file references.
- [ ] Sync status indicator (online, syncing, offline, last synced time) visible in Settings.
