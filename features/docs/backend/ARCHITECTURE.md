# Backend Architecture & Cloud Infrastructure (Supabase & PowerSync)

> Target Cloud Infrastructure for Kashkool (كشكول) — Phase 2 & Phase 3.

---

## 1. High-Level Architecture Overview

Kashkool utilizes an **Offline-First, Cloud-Synced** architecture designed for the Egyptian retail environment (where shop cellular connectivity is intermittent and power cuts or network blackouts occur).

```
┌─────────────────────────────────────────────────────────────┐
│                    Mobile Client (Flutter)                  │
│                                                             │
│  UI / Screens (Riverpod)                                    │
│       │                                                     │
│       ▼                                                     │
│  Repositories                                               │
│       │                                                     │
│       ▼                                                     │
│  Drift Local DB (SQLCipher 256-bit AES Encrypted SQLite)    │
└──────────────────────────┬──────────────────────────────────┘
                           │
                 PowerSync SQLite Extension
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                 PowerSync Cloud Replication                 │
│                                                             │
│  - Persistent WebSocket bi-directional sync                 │
│  - Dynamic partitioning buckets by shop_id                  │
│  - Offline queuing and automatic retry on reconnect         │
└──────────────────────────┬──────────────────────────────────┘
                           │
                     Postgres WAL / CDC
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│               Supabase Cloud (Frankfurt: eu-central-1)      │
│                                                             │
│  - PostgreSQL 15+ (Database mirroring local tables)         │
│  - Row Level Security (RLS) enforcing tenant isolation      │
│  - Supabase Auth (Google OAuth first, Phone OTP later)      │
│  - Supabase Storage (receipts, contracts, attachments)      │
│  - Deno Edge Functions (Serverless microservices)           │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Infrastructure & Hosting Specifications

| Component | Technology | Hosting / Region | Rationale |
|---|---|---|---|
| **Primary Database** | PostgreSQL 15+ | **Supabase (Frankfurt `eu-central-1`)** | Lowest ping to Egyptian ISPs (~50–70 ms); complies with international data standards. |
| **Replication Engine** | PowerSync | Frankfurt Cloud | Handles offline sync, conflict avoidance, and delta compression out of the box. |
| **Authentication** | Supabase Auth | Native Google OAuth | Instant 1-tap sign-in on Android; eliminates high SMS OTP cost and carrier delivery drops in Egypt. |
| **File Storage** | Supabase Storage | S3-compatible Frankfurt | Compressed receipt photos and installment contracts with signed secure URLs. |
| **Serverless Logic** | Deno Edge Functions | Edge Global Distribution | Low latency execution for purchase verification, statement rendering, and AI vision proxy. |

---

## 3. Server Schema (Mirroring Local Tables)

All tables share standard metadata for sync, multi-tenancy, and audit trails:

```sql
-- Base column convention for every synchronized table:
-- id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
-- shop_id    UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
-- device_id  TEXT NOT NULL,
-- created_by TEXT NOT NULL,
-- created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
-- updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
-- deleted_at TIMESTAMPTZ NULL
```

### Table Definitions

```sql
-- 1. Shops Table
CREATE TABLE public.shops (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    shop_type TEXT NOT NULL, -- grocery, mobile, electronics, pharmacy, other
    phone TEXT,
    address TEXT,
    currency TEXT NOT NULL DEFAULT 'EGP',
    enable_installments BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

-- 2. Shop Members (Multi-User & Roles)
CREATE TABLE public.shop_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    device_id TEXT NOT NULL,
    created_by TEXT NOT NULL,
    name TEXT NOT NULL,
    phone TEXT,
    role TEXT NOT NULL DEFAULT 'cashier', -- owner, manager, cashier
    custom_permissions JSONB NOT NULL DEFAULT '{}'::jsonb,
    active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ,
    UNIQUE (shop_id, user_id)
);

-- 3. Customers
CREATE TABLE public.customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
    device_id TEXT NOT NULL,
    created_by TEXT NOT NULL,
    name TEXT NOT NULL,
    phone TEXT,
    national_id TEXT, -- Optional (Egypt Law 151/2020)
    notes TEXT,
    credit_limit_piasters BIGINT,
    last_reminder_at TIMESTAMPTZ,
    snoozed_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

-- 4. Transactions (Append-Only Financial Ledger)
CREATE TABLE public.transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
    device_id TEXT NOT NULL,
    created_by TEXT NOT NULL,
    superseded_by_id UUID REFERENCES public.transactions(id),
    party_type TEXT NOT NULL, -- customer, supplier
    party_id UUID NOT NULL,
    type TEXT NOT NULL, -- debt (عليه), payment (دفع)
    amount_piasters BIGINT NOT NULL CHECK (amount_piasters > 0),
    method TEXT, -- cash, instapay, wallet, other
    note TEXT,
    photo_path TEXT,
    occurred_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

-- 5. Installment Plans
CREATE TABLE public.installment_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
    device_id TEXT NOT NULL,
    created_by TEXT NOT NULL,
    plan_number TEXT NOT NULL, -- Device prefixed (e.g. DEV1-0042)
    customer_id UUID NOT NULL REFERENCES public.customers(id),
    item_description TEXT NOT NULL,
    item_serial TEXT,
    cash_price_piasters BIGINT NOT NULL,
    markup_type TEXT NOT NULL DEFAULT 'none',
    markup_value BIGINT NOT NULL DEFAULT 0,
    total_price_piasters BIGINT NOT NULL,
    down_payment_piasters BIGINT NOT NULL DEFAULT 0,
    installment_count INT NOT NULL,
    frequency TEXT NOT NULL DEFAULT 'monthly',
    first_due_date DATE NOT NULL,
    due_day_of_month INT,
    guarantor_name TEXT,
    guarantor_phone TEXT,
    guarantor_national_id TEXT, -- Optional
    customer_national_id TEXT, -- Optional
    late_fee_type TEXT NOT NULL DEFAULT 'none',
    late_fee_piasters BIGINT,
    grace_days INT NOT NULL DEFAULT 3,
    status TEXT NOT NULL DEFAULT 'active',
    completed_at TIMESTAMPTZ,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

-- 6. Installments (Schedules)
CREATE TABLE public.installments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
    device_id TEXT NOT NULL,
    created_by TEXT NOT NULL,
    plan_id UUID NOT NULL REFERENCES public.installment_plans(id) ON DELETE CASCADE,
    index INT NOT NULL,
    due_date DATE NOT NULL,
    original_due_date DATE NOT NULL,
    amount_piasters BIGINT NOT NULL,
    late_fee_piasters BIGINT NOT NULL DEFAULT 0,
    waived_piasters BIGINT NOT NULL DEFAULT 0,
    fully_paid_at TIMESTAMPTZ,
    postpone_count INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

-- 7. Suppliers
CREATE TABLE public.suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
    device_id TEXT NOT NULL,
    created_by TEXT NOT NULL,
    name TEXT NOT NULL,
    phone TEXT,
    company TEXT,
    visit_day INT,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

-- 8. Subscriptions
CREATE TABLE public.subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
    plan TEXT NOT NULL DEFAULT 'free', -- free, pro, installments_pro
    status TEXT NOT NULL DEFAULT 'active', -- active, in_grace, cancelled, expired
    source TEXT NOT NULL DEFAULT 'google_play',
    external_subscription_id TEXT,
    current_period_start TIMESTAMPTZ NOT NULL,
    current_period_end TIMESTAMPTZ NOT NULL,
    trial_end TIMESTAMPTZ,
    cancel_at_period_end BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

-- 9. Shareable Statement Links
CREATE TABLE public.statement_links (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES public.shops(id) ON DELETE CASCADE,
    customer_id UUID NOT NULL REFERENCES public.customers(id) ON DELETE CASCADE,
    token TEXT NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    is_revoked BOOLEAN NOT NULL DEFAULT false,
    view_count INT NOT NULL DEFAULT 0,
    last_viewed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);
```

---

## 4. Row Level Security (RLS) Implementation

Tenant isolation is strictly enforced at the database kernel level:

```sql
-- Enable RLS on all public tables
ALTER TABLE public.shops ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shop_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.installment_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.installments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.statement_links ENABLE ROW LEVEL SECURITY;

-- Security helper function to get current user's active shops
CREATE OR REPLACE FUNCTION public.get_auth_shop_ids()
RETURNS SETOF UUID
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
    SELECT shop_id FROM public.shop_members
    WHERE user_id = auth.uid() AND active = true;
$$;

-- Global policy template for shop tenancy
CREATE POLICY "Shop members can read shop data"
ON public.customers
FOR SELECT
USING (shop_id IN (SELECT public.get_auth_shop_ids()));

CREATE POLICY "Shop members can insert shop data"
ON public.customers
FOR INSERT
WITH CHECK (shop_id IN (SELECT public.get_auth_shop_ids()));

CREATE POLICY "Shop members can update shop data"
ON public.customers
FOR UPDATE
USING (shop_id IN (SELECT public.get_auth_shop_ids()))
WITH CHECK (shop_id IN (SELECT public.get_auth_shop_ids()));

-- Role restriction: Only Owners and Managers can soft-delete or manage sensitive data
CREATE POLICY "Only owners and managers can soft delete transactions"
ON public.transactions
FOR UPDATE
USING (
    shop_id IN (
        SELECT shop_id FROM public.shop_members
        WHERE user_id = auth.uid() AND active = true AND role IN ('owner', 'manager')
    )
);
```

---

## 5. Supabase Edge Functions (Serverless Microservices)

Edge Functions are written in TypeScript running on Deno at edge locations worldwide:

### 1. `verify-play-purchase`
- **Trigger**: Called by app upon completing Google Play in-app purchase flow, or via Google Cloud Pub/Sub Real-Time Developer Notifications (RTDN).
- **Functionality**:
  1. Validates `purchaseToken` and `subscriptionId` against Google Play Developer API (Android Publisher API v3).
  2. Extracts entitlement duration and renewal status.
  3. Updates or inserts row into `public.subscriptions`.
  4. Returns active entitlement JSON payload to client.

### 2. `qualify-referral`
- **Trigger**: Scheduled cron job (daily) or post-transaction webhook.
- **Functionality**:
  1. Checks referred shops linked via `settings.shopCode`.
  2. Evaluates anti-fraud rules: verifies $\ge 10$ transactions across $\ge 3$ distinct calendar days on distinct hardware device IDs.
  3. If qualified, awards +30 days Pro subscription to referrer and +14 days to referee.

### 3. `create-statement-link` & `render-statement`
- **Trigger**: HTTP GET `https://kashkool.app/s/{token}`.
- **Functionality**:
  1. Looks up token in `public.statement_links`.
  2. Checks `expires_at > now()` and `is_revoked = false`.
  3. Increments `view_count` and updates `last_viewed_at`.
  4. Queries shop name, customer name, transactions, and computes running balance.
  5. Renders lightweight, responsive Arabic RTL HTML with zero PII (no phone numbers or national IDs).

### 4. `notebook-ai-import`
- **Trigger**: HTTP POST multipart image from Camera Notebook Import (17).
- **Functionality**:
  1. Verifies shop subscription quota (first 5 pages free, then Pro subscription required).
  2. Calls vision LLM (Gemini 1.5 Flash) with structured JSON extraction prompt tailored for Egyptian colloquial handwriting.
  3. Returns parsed rows: `[{ name: string, amount: int, type: "debt"|"payment", confidence: float }]`.
  4. Discards image bytes immediately from RAM (zero server storage retention).

### 5. `remote-config`
- **Trigger**: App launch HTTP GET.
- **Functionality**:
  - Delivers dynamic operational constants: minimum supported app version, placeholder subscription prices, emergency maintenance banners, and feature flags.

---

## 6. Security, Compliance & Backup Strategy

1. **Local Encryption at Rest**: Client devices use SQLite encrypted with SQLCipher 256-bit AES (`drift` + `sqlcipher_flutter_libs`). Keys never leave the local secure hardware enclave (`flutter_secure_storage`).
2. **Transport Security**: All traffic over TLS 1.3 with HTTPS and WSS (WebSocket Secure).
3. **Egyptian Law 151/2020 Compliance**:
   - Customer and guarantor national IDs are optional.
   - Purpose limitation: data processed exclusively for shop bookkeeping.
   - Right to erasure and data portability: merchants can export or wipe all records instantly.
