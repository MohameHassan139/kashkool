# 13 — Cloud Sync & Accounts

**Phase:** 2 · **Tier:** Paid · **Depends on:** Phase 1 complete, 16

## User story
As a shop owner, I want my data safe if my phone is lost, and available on more
than one phone.

## Approach
- **Supabase**: phone OTP auth, Postgres mirror of local tables, Storage for photos.
- **Local-first**: Drift remains the source of truth for UI; sync runs in background.
- Each record already has UUID + `updatedAt` + `deletedAt` → **last-write-wins** per row.
- Tables gain `shopId` and `syncedAt` columns (migration).
- Row Level Security: users only access rows of shops they belong to.

## Sync flow
1. Push: local rows where `updatedAt > syncedAt` → upsert to Supabase.
2. Pull: remote rows where `updatedAt > lastPullAt` → upsert locally.
3. Photos: upload on Wi-Fi or when user allows mobile data.
4. Trigger: app start, after each write (debounced 30 s), periodic workmanager, manual "زامن دلوقتي".

## First-time enable
- Existing local data uploaded to a new shop account.
- Signing in on a new phone downloads everything.

## Acceptance Criteria
- [ ] Offline edits sync when back online, no data loss.
- [ ] Two devices editing different records converge.
- [ ] Same record edited on two devices → latest `updatedAt` wins.
- [ ] RLS tested: user A cannot read shop B.
- [ ] Sync status visible (last synced time, error state).
