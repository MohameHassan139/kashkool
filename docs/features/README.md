# Feature Specs — Index

Each file is a self-contained specification for one feature. The agent and engineering team must read the relevant file **before** planning or coding that feature, and follow its Acceptance Criteria as the definition of done.

| # | Feature | Phase | Tier | File |
|---|---------|:-----:|:----:|------|
| **00** | Onboarding & Shop Personalization | 1 | Free | [00-onboarding.md](00-onboarding.md) |
| **01** | Project setup & SQLCipher Encryption | 1 | Free | [01-project-setup.md](01-project-setup.md) |
| **02** | Customers (العملاء) | 1 | Free | [02-customers.md](02-customers.md) |
| **03** | Transactions: Debt & Payment (Append-Only) | 1 | Free | [03-transactions.md](03-transactions.md) |
| **04** | Credit limit (حد الدين) | 1 | Free | [04-credit-limit.md](04-credit-limit.md) |
| **05** | Customer rating (تقييم العميل - FIFO) | 1 | Free | [05-customer-rating.md](05-customer-rating.md) |
| **06** | Suppliers ledger (دفتر الموردين) | 1 | Free | [06-suppliers-ledger.md](06-suppliers-ledger.md) |
| **07** | Daily collection & WhatsApp reminders | 1 | Free | [07-daily-collection-whatsapp.md](07-daily-collection-whatsapp.md) |
| **08** | Customer statement PDF (كشف حساب) | 1 | Free | [08-statement-pdf.md](08-statement-pdf.md) |
| **09** | Cash drawer closing (تقفيل الدرج) | 1 | Free | [09-cash-drawer.md](09-cash-drawer.md) |
| **10** | Home screen widget | 1 | Free | [10-home-widget.md](10-home-widget.md) |
| **11** | Growth footer & referral link | 1 | Free | [11-growth-footer.md](11-growth-footer.md) |
| **12** | Settings, security, battery guide & backup | 1 | Free | [12-settings-security.md](12-settings-security.md) |
| **13** | Cloud sync & accounts (PowerSync + Supabase) | 2 | Paid (79 EGP) | [13-cloud-sync.md](13-cloud-sync.md) |
| **14** | Installments system ⭐ (نظام الأقساط) | 2 | Paid (149 EGP / 1 free plan) | [14-installments.md](14-installments.md) |
| **15** | Employee permissions (صلاحيات العمال) | 2 | Paid (79 EGP) | [15-employee-permissions.md](15-employee-permissions.md) |
| **16** | Subscription paywall (Google Play Billing) | 2 | System | [16-subscription-paywall.md](16-subscription-paywall.md) |
| **20** | Shareable customer statement web link | 2 | Paid (79 EGP) | [20-statement-link.md](20-statement-link.md) |
| **21** | Crash reporting & privacy analytics | 2 | System | [21-crash-analytics.md](21-crash-analytics.md) |
| **17** | Notebook import via camera (AI Vision) | 3 | Paid (5 pages free) | [17-notebook-import.md](17-notebook-import.md) |
| **18** | Offers & greetings broadcaster | 3 | Paid (79 EGP) | [18-offers-broadcaster.md](18-offers-broadcaster.md) |
| **19** | Referral program (اكسب شهر مجاناً) | 3 | Free / Rewards | [19-referral-program.md](19-referral-program.md) |
| **22** | Internal operations & admin dashboard | 3 | Internal Ops | [22-admin-dashboard.md](22-admin-dashboard.md) |

---

## Shared Conventions & Architecture Standards

### 1. Money Representation
- Money is strictly stored as **integer piasters** (`int` / `BIGINT`), never double or float.
- 1 Egyptian Pound (EGP) = 100 piasters.
- Formatted with Arabic thousands separator without unnecessary decimals (e.g. `1,250 ج.م`, `12.50 ج.م`).

### 2. Multi-Tenancy & Sync Metadata (Every Table)
Every table from Phase 1 onwards includes standard fields:
- `id`: Text (UUID v4)
- `shopId`: Text (UUID v4, references `shops.id`)
- `deviceId`: Text (Hardware UUID of the creating device)
- `createdBy`: Text (User/device identifier)
- `createdAt`: DateTime (UTC)
- `updatedAt`: DateTime (UTC)
- `deletedAt`: DateTime? (Nullable UTC for soft delete)

### 3. Append-Only Financial Records
- Financial transactions and payments are **immutable and append-only**.
- Edits are performed by soft-deleting the old row (`deletedAt = now()`, `supersededById = newId`) and inserting a new replacement row. Hard deletion is forbidden.

### 4. Derived Values (Local Only)
- Customer balances, supplier balances, installment `paidPiasters`, installment statuses, and cash drawer differences are **dynamically computed** from raw ledger rows.
- Derived values are **never stored as synchronized columns** to prevent multi-device race conditions.

### 5. Local Encryption & Privacy Compliance
- Local Drift SQLite database is encrypted with **SQLCipher** (256-bit AES).
- Compliant with **Egypt Personal Data Protection Law (151/2020)**:
  - Customer and guarantor National IDs are strictly **optional**.
  - All outgoing web links (20) redact personal identifying information (no phones, no national IDs).
  - Clear in-app Privacy Policy and Terms of Service.

### 6. Phone Numbers & Regional Formatting
- Input format: Egyptian mobile `01XXXXXXXXX` (11 digits starting with 010, 011, 012, or 015).
- WhatsApp URL format: `20` + number without leading 0 → `201XXXXXXXXX`.
