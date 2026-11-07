# 12 — Settings, Security & Backup File

**Phase:** 1 · **Tier:** Free · **Depends on:** 01

## Settings storage
Key-value `settings` table (or `shared_preferences` for non-critical UI prefs).

## Sections
### بيانات المحل (Shop info)
- Shop name, phone, address, logo (optional), payment info (InstaPay handle, wallet number).

### التذكيرات (Reminders) — used by 07
- Daily reminder time, `reminderIntervalDays`, `minDebtAgeDays`.
- Message template editor with placeholder chips + live preview + presets (ودّي / رسمي).

### الحماية والخصوصية (Security & privacy)
- App lock: biometric (`local_auth`) with PIN fallback (4 digits, hashed). Lock on launch
  and after N minutes in background.
- **Privacy mode**: eye icon in app bar toggles hiding all amounts (`•••`). Persisted.

### البيانات (Data)
- **Export**: copy the SQLite DB + photos into a single `.kashkool` (zip) file → share/save.
- **Import**: pick file → validate → confirm "هيستبدل كل البيانات الحالية" → restore.
- Reminder banner every 7 days if no export: "اعمل نسخة احتياطية" (later: upsell cloud).

### عام (General)
- Theme (system / light / dark), language (Arabic now, English later), default credit limit.
- About, privacy policy, contact on WhatsApp.

## Acceptance Criteria
- [ ] All settings persist across restarts.
- [ ] Biometric lock works; PIN fallback works; no bypass via recent apps.
- [ ] Export → uninstall → reinstall → import restores everything incl. photos.
- [ ] Import rejects invalid/corrupted files safely.
