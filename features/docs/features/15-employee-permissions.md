# 15 — Employee Permissions (صلاحيات العمال)

**Phase:** 2 · **Tier:** Paid · **Depends on:** 13

## User story
As a shop owner, I want my employee to record sales and debts on his own phone
without being able to delete records or see my profits.

## Model
- `shop_members`: `shopId`, `userId`, `role` (owner / employee), `permissions` (JSON), `active`.
- Invite: owner generates invite code / QR → employee installs app, signs in, enters code.

## Default employee permissions
| Action | Employee |
|---|---|
| Add customer / transaction | ✅ |
| Edit own transaction (within 10 min) | ✅ |
| Delete anything | ❌ |
| Edit others' transactions | ❌ |
| See totals, cash drawer, reports | ❌ (configurable) |
| Suppliers | ❌ (configurable) |
| Settings / export | ❌ |

- Every transaction stores `createdBy`; owner sees who recorded what.
- Enforce in **both** UI and Supabase RLS (never trust the client alone).
- Owner can deactivate an employee instantly (device loses access on next sync).

## Acceptance Criteria
- [ ] Employee cannot perform forbidden actions via UI or direct API.
- [ ] Owner sees `createdBy` on each transaction and a filter by employee.
- [ ] Deactivation works within one sync cycle.
