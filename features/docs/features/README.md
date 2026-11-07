# Feature Specs — Index

Each file is a self-contained spec for one feature. The agent must read the
relevant file **before** planning or coding that feature, and follow its
Acceptance Criteria as the definition of done.

| # | Feature | Phase | Tier | File |
|---|---------|-------|------|------|
| 01 | Project setup | 1 | — | [01-project-setup.md](01-project-setup.md) |
| 02 | Customers | 1 | Free | [02-customers.md](02-customers.md) |
| 03 | Transactions (debt / payment) | 1 | Free | [03-transactions.md](03-transactions.md) |
| 04 | Credit limit | 1 | Free | [04-credit-limit.md](04-credit-limit.md) |
| 05 | Customer rating | 1 | Free | [05-customer-rating.md](05-customer-rating.md) |
| 06 | Suppliers ledger | 1 | Free | [06-suppliers-ledger.md](06-suppliers-ledger.md) |
| 07 | Daily collection & WhatsApp reminders | 1 | Free | [07-daily-collection-whatsapp.md](07-daily-collection-whatsapp.md) |
| 08 | Customer statement PDF | 1 | Free | [08-statement-pdf.md](08-statement-pdf.md) |
| 09 | Cash drawer closing | 1 | Free | [09-cash-drawer.md](09-cash-drawer.md) |
| 10 | Home screen widget | 1 | Free | [10-home-widget.md](10-home-widget.md) |
| 11 | Growth footer & referral link | 1 | Free | [11-growth-footer.md](11-growth-footer.md) |
| 12 | Settings, security & backup file | 1 | Free | [12-settings-security.md](12-settings-security.md) |
| 13 | Cloud sync & accounts | 2 | Paid | [13-cloud-sync.md](13-cloud-sync.md) |
| 14 | Installments | 2 | Paid | [14-installments.md](14-installments.md) |
| 15 | Employee permissions | 2 | Paid | [15-employee-permissions.md](15-employee-permissions.md) |
| 16 | Subscription & paywall | 2 | Paid | [16-subscription-paywall.md](16-subscription-paywall.md) |
| 17 | Notebook import via camera (AI) | 3 | Paid | [17-notebook-import.md](17-notebook-import.md) |
| 18 | Offers & greetings broadcaster | 3 | Paid | [18-offers-broadcaster.md](18-offers-broadcaster.md) |
| 19 | Referral program | 3 | Free/Paid | [19-referral-program.md](19-referral-program.md) |

## Shared conventions (apply to every feature)
- Money = `int` piasters (1 EGP = 100). Display with thousands separator, no decimals
  unless non-zero (e.g. `1,250 ج.م`, `12.50 ج.م`).
- Every table: `id` (UUID v4 string), `createdAt`, `updatedAt`, `deletedAt` (nullable, soft delete).
- All dates stored UTC, displayed in device local time (Africa/Cairo default).
- All user-facing strings in ARB files (`app_ar.arb` first).
- Egyptian phone: input `01XXXXXXXXX` (11 digits, prefix 010/011/012/015).
  WhatsApp format: `20` + number without leading `0` → `201XXXXXXXXX`.
