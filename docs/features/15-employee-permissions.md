# 15 — Employee Permissions & Multi-User Shop Access (صلاحيات العمال)

**Phase:** 2 · **Tier:** Paid (Pro & Installments Pro) · **Depends on:** 13 Cloud Sync, 16 Paywall

## User story
As a shop owner, I want my cashier or shop assistant to record sales, customer debts, and received payments on their own phone, without allowing them to delete records, alter past transactions, view my total profits, or see supplier costs.

---

## 1. Data Model

### `shop_members`
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 |
| shopId | text | FK → shops.id |
| deviceId | text | Device hardware identifier |
| createdBy | text | Inviting owner user UUID |
| userId | text | Supabase auth user UUID |
| name | text | Employee display name (e.g. "محمود الكاشير") |
| phone | text | Employee phone number |
| role | enum | `owner` \| `manager` \| `cashier` |
| customPermissions | jsonb | Granular permission overrides |
| active | bool | Default true. Instant deactivation |
| createdAt, updatedAt, deletedAt | datetime | UTC timestamps |

---

## 2. Permission Matrix

| Action | Owner (صاحب المحل) | Cashier (العامل / الكاشير) |
|---|:---:|:---:|
| Add Customer / Supplier | ✅ | ✅ |
| Record Debt ("عليه") & Payment ("دفع") | ✅ | ✅ |
| Soft-Delete any record | ✅ | ❌ (Strictly Forbidden) |
| View Total Receivables & Profit Dashboards | ✅ | ❌ (Hidden in UI & RLS) |
| Access Cash Drawer Closing ("تقفيل الدرج") | ✅ | ❌ (Configurable) |
| View Suppliers Ledger ("دفتر الموردين") | ✅ | ❌ (Configurable) |
| Export / Import `.kashkool` Database | ✅ | ❌ |
| Manage Subscriptions & Members | ✅ | ❌ |

---

## 3. Security Enforcement: UI + Supabase RLS

1. **Client UI Enforcement**: Navigation items, delete buttons, total balances, and supplier tabs are conditionally hidden or disabled based on `currentUserRole`.
2. **Server-Side RLS (Never Trust the Client)**:
   ```sql
   -- Cashiers cannot DELETE any row in transactions table
   CREATE POLICY "Employees cannot delete transactions"
   ON public.transactions
   FOR DELETE
   USING (
     EXISTS (
       SELECT 1 FROM public.shop_members 
       WHERE shop_id = public.transactions.shop_id 
       AND user_id = auth.uid() 
       AND role IN ('owner', 'manager')
     )
   );
   ```
3. **Audit Trail**: Every transaction stores `createdBy` = `auth.uid()`. The owner's transaction log displays an employee filter and badge (e.g. *"سجّلها: محمود الكاشير"*).
4. **Instant Deactivation**: When owner toggles `active = false`, Supabase session is revoked via Edge Function and PowerSync stops synchronizing data to the employee's device immediately.

---

## Acceptance Criteria
- [ ] Employee invite via QR code / 6-digit code links employee phone to shop.
- [ ] Employee cannot delete or edit records beyond allowed parameters in UI or via direct Supabase API.
- [ ] Owner sees employee attribution on each transaction.
- [ ] Deactivating an employee revokes shop data access on their next sync cycle.
