# Frontend Review — Kashkool (Nov 7, 2026)

Static code review of `lib/`, `test/`, `pubspec.yaml`, and `android/` against `docs/features/*`.
`flutter analyze` and `flutter test` were **not** run, and the UI was not checked on a device.
Treat every item as "verify, then fix".

Legend: ✅ done · 🟡 partly done · ❌ not started · 🐞 bug

---

## 1. Feature status

| # | Feature | Status | Notes |
|---|---|---|---|
| 00 | Onboarding | ✅ | Shop info, shop type toggles installments, notification permission, battery guide, and sample data are present. Referral code field: verify. |
| 01 | Project setup | 🟡 | Structure, theme, RTL, Cairo font, router, and Drift are done. **DB encryption is not active (🐞 B1).** `applicationId` is still `com.example.kashkool`. App label is the English "kashkool". Launcher icon is still the Flutter default. |
| 02 | Customers | ✅ | CRUD, Arabic search, duplicate check, credit limit, national ID. Missing: pick from contacts (minor). |
| 03 | Transactions | 🟡 | Keypad, quick chips, voice, photo, and undo are present. **Edits update rows in place, and undo hard-deletes (🐞 B5).** Voice will likely fail: `RECORD_AUDIO` permission is missing (🐞 B3). |
| 04 | Credit limit | ✅ | Has tests. |
| 05 | Customer rating | ✅ | FIFO logic with tests. **Results are wrong for installment customers (🐞 B4).** |
| 06 | Suppliers | ✅ | Includes visit day. Visit-day notification not done (needs B2). |
| 07 | Collection + WhatsApp | 🟡 | Screen, WhatsApp, SMS, call, snooze, "اتبعت؟", and installments tab are done. **The daily notification is never scheduled (🐞 B2).** The call button may silently fail on Android 11+ (🐞 B3). |
| 08 | Statement PDF | ✅ | Cairo font, RTL, growth footer. |
| 09 | Cash drawer | ✅ | Has tests. Installment down payment is always recorded as cash (no method choice). |
| 10 | Home widget | ✅ | Small and medium sizes, deep link, privacy mode. |
| 11 | Growth footer | ✅ | Stable shop code. |
| 12 | Settings & security | ✅ | Shop profile, template editor, PIN + biometric, privacy mode, backup with photos, backup banner, privacy policy, battery guide. Verify "delete all my data". After B1, backup and restore must still work with the encrypted DB. |
| 14 | Installments | 🟡 | Done: create plan, month-end-safe schedule, FIFO payment rollover, early settlement, cancel, list/filters, due tab, call buttons. Missing: see section 3. **Plan totals are posted into the regular credit ledger (🐞 B4).** |
| 18 | Offers broadcaster | ❌ | |
| 21 | Crash reporting (Sentry) | ❌ | Not in `pubspec.yaml`. |
| 13, 15, 16, 17, 19, 20, 22 | Backend features | ❌ | Expected at this stage (Part B). |

---

## 2. Bugs and blockers (fix before giving the app to any shop)

### 🐞 B1 — Database is NOT encrypted
- `DatabaseEncryptionHelper.getOrCreateKey()` exists but is **never called**. `AppDatabase._openConnection()` opens a plain SQLite file.
- `pubspec.yaml` has both `sqlite3_flutter_libs` and `sqlcipher_flutter_libs` (marked `eol`). They must not be used together.
- The fallback key `'kashkool_local_fallback_key_2026'` is hard-coded. In release builds, failing to read secure storage must be an error, not a silent fallback to a known key.
- Existing installs have an unencrypted DB, so a one-time migration to an encrypted DB is needed (e.g. `sqlcipher_export`).
- Backup/restore (`backup_service.dart`) must keep working.

### 🐞 B2 — Daily collection notification never fires
- `NotificationService.showCollectionNotification()` is **never called**, and nothing schedules it. `workmanager` is not installed.
- `POST_NOTIFICATIONS` permission is missing from `AndroidManifest.xml`, so on Android 13+ the permission request does nothing.
- Needed:
  - A daily background job at the chosen time that computes the due list and shows the notification.
  - Rescheduling after reboot.
  - An in-app banner fallback when the job didn't run (spec 07).

### ✅ B3 — AndroidManifest is missing permissions and intent queries (Resolved)
- Added `POST_NOTIFICATIONS` and `RECORD_AUDIO` permissions.
- Added `<queries>` entries for `android.speech.RecognitionService`, `tel:`, `sms:`, and `https:`.
- Replaced `canLaunchUrl()` across all calling and messaging buttons with direct, safe `launchUrl()` calls in `try/catch`.
- Set `android:label="كشكول"`.

### 🐞 B4 — Installments are mixed into the regular credit ledger
`InstallmentRepository.createPlan(linkToCustomerLedger: true)` posts the **whole plan price as a regular debt**. As a result:
- The customer's regular balance includes money that isn't due yet.
- The rating turns 🔴 after 45 days even when the customer pays every installment on time.
- The Collection screen asks the shop owner to collect the full price.
- Credit-limit warnings fire wrongly.
- Cancelling a plan leaves the full debt on the customer.

Spec 14 §4.4 says to keep them separate:
- Add `installmentPlanId` to `transactions`.
- Never post the financed amount as a debt.
- Exclude installment rows from the regular balance, rating, collection, and credit limit.
- Keep them in the cash drawer.
- Write a migration for existing linked rows.

### 🐞 B5 — Financial records are not append-only
- `TransactionRepository.updateTransaction()` edits amounts in place, and `supersededById` is never set.
  It should soft-delete the old row, insert a new one, and set `supersededById` on the old row.
- `undoTransaction()` hard-deletes. It should soft-delete.
- In installments, `paidPiasters` and `status` are updated in place, and payments aren't linked to the plan. This means a payment can't be edited or deleted with correct reallocation. Fix together with B4: store payments as transactions with `installmentPlanId`, and recompute allocation (spec 14 §5.3).

### 🐞 B6 — `shopId` / `deviceId` / `createdBy` are not filled
Only `seedSampleData()` sets them. Every normal insert uses the column defaults (`default_shop`, `local_device`, `owner`). Also, seed data uses `'default-shop'` (hyphen) while the default is `'default_shop'` (underscore).
- Fix: one provider that supplies the current shop/device context, used by every repository insert.
- Write a migration that backfills existing rows with the real shop ID and device ID.

### 🐞 B7 — Application ID
`applicationId` and `namespace` are `com.example.kashkool`. Google Play rejects `com.example`, and changing the ID after testers install the app means a new app with their data lost. **Change it before the first test install** (for example to `app.kashkool`), including the Kotlin package path for `MainActivity` and the widget providers.

---

## 3. Installments: what's missing vs spec 14

| Milestone | Status |
|---|---|
| 14a tables | 🟡 Missing columns: `planNumber`, `itemSerial` (IMEI), `cashPricePiasters` + markup, `graceDays`, late fee, `originalDueDate`, `postponeCount`, `waivedPiasters`, statuses `settled_early`/`defaulted`. Missing tables: `installment_attachments` (only one `photoPath` exists), `installment_events`. |
| 14b calculator | 🟡 Schedule and early settlement are tested. Missing: markup, 5-EGP rounding option, derived statuses (`in_grace`, `late`), allocation as a pure function, property-based test. |
| 14c wizard + details | 🟡 Exists. Missing: markup step, IMEI scan, down payment method, guarantor ID. |
| 14d payments | 🟡 Pay + rollover exists. Missing: edit/delete payment with reallocation, undo (depends on B4/B5). |
| 14e reminders | 🟡 Due tab exists. Verify installment WhatsApp templates and placeholders, and include installments in the daily notification (after B2). |
| 14f postpone / reschedule / events | ❌ |
| 14g attachments + PDFs (contract, statement, receipt) | ❌ |
| 14h reports | ❌ |
| Free limit (1 active plan) | ❌ (add as a flag now; real paywall comes in Part B) |

---

## 4. Code quality

- About **140 hard-coded Arabic strings** (`Text('...')`), mostly in installments, settings, and onboarding. They break the "ARB only" rule. Move them to `app_ar.arb`/`app_en.arb`.
- `AppDatabase.beforeOpen` runs `ALTER TABLE` inside try/catch on **every launch**. Replace it with a proper schema-version migration.
- PIN is a 4-digit SHA-256 hash with no attempt limit. Add a lockout after 5 wrong attempts.
- `custom_lint.log` (≈900 KB) is in the repo root. Add it to `.gitignore`.
- Root `README.md` is still the Flutter template.
- Duplicate docs folders at the root (`features/`, `new/`) should be deleted.

---

## 5. Fix plan — prompts for Antigravity (in order)

Run **one prompt at a time**. Approve the plan first, test on a real phone, then commit.

**F1 — Application ID (B7)**
```
اقرا docs/FRONTEND_REVIEW.md (B7). غيّر applicationId و namespace من com.example.kashkool
لـ app.kashkool، وانقل الـ Kotlin package (MainActivity والـ widget providers) وعدّل
AndroidManifest، وخلّي android:label = "كشكول". اتأكد إن الـ widgets لسه شغالة. اعرض الخطة الأول.
```

**F2 — Manifest permissions and queries (B3)**
```
نفّذ B3 من docs/FRONTEND_REVIEW.md: ضيف POST_NOTIFICATIONS و RECORD_AUDIO، و <queries> لـ
tel و sms و https و RecognitionService. واستبدل canLaunchUrl في أزرار الاتصال بـ launchUrl
مباشرة زي WhatsAppTemplateUtils. اعرض الخطة الأول.
```

**F3 — Real encryption (B1)**
```
نفّذ B1 من docs/FRONTEND_REVIEW.md: شغّل SQLCipher فعلاً بالمفتاح من DatabaseEncryptionHelper،
وشيل التعارض بين sqlite3_flutter_libs و sqlcipher_flutter_libs حسب توثيق drift الحالي،
وشيل المفتاح الاحتياطي الثابت في الـ release، واعمل migration مرة واحدة للداتابيز القديمة
الغير مشفرة، واتأكد إن backup/restore شغالين. اكتب test إن الملف مش بيتفتح من غير مفتاح.
اعرض الخطة الأول.
```

**F4 — Shop/device context on every insert (B6)**
```
نفّذ B6 من docs/FRONTEND_REVIEW.md: provider واحد بيدي shopId و deviceId و createdBy،
وكل الـ repositories تستخدمه في كل insert، و migration تملا الصفوف القديمة بالقيم الحقيقية.
اعرض الخطة الأول.
```

**F5 — Append-only transactions (B5, transactions part)**
```
نفّذ B5 لجزء العمليات بس من docs/FRONTEND_REVIEW.md: التعديل = soft delete + صف جديد مع
supersededById، والتراجع = soft delete. حدّث الـ tests. اعرض الخطة الأول.
```

**F6 — Separate installments from the credit ledger (B4 + B5 installments part)**
```
نفّذ B4 من docs/FRONTEND_REVIEW.md وجزء الأقساط في B5، حسب docs/features/14-installments.md
القسم 4.4 و 5.3: عمود installmentPlanId في transactions، متسجلش سعر الخطة كـ دين، استبعد
عمليات الأقساط من الرصيد والتقييم والتحصيل وحد الدين، وخلّيها في الدرج. paidPiasters يتحسب
من المدفوعات (allocation دالة pure مع tests). اعمل migration للبيانات القديمة. اعرض الخطة الأول.
```

**F7 — Daily notification (B2)**
```
نفّذ B2 من docs/FRONTEND_REVIEW.md حسب docs/features/07-daily-collection-whatsapp.md:
job يومي في الميعاد المختار يحسب المستحقين (عملاء + أقساط) ويعرض الإشعار، يرجع يتجدول بعد
الـ reboot، و banner جوه التطبيق لو الإشعار مااشتغلش. جرّبه على موبايل شاومي أو أوبو.
اعرض الخطة الأول.
```

**F8 — Sentry**
```
نفّذ جزء Sentry من docs/features/21-crash-analytics.md، ومفيش أي بيانات عملاء تتبعت.
اعرض الخطة الأول.
```

**F9 — Installments milestones (section 3)**
Send one prompt per milestone:
```
نفّذ milestone <14a/14b/14c/14d/14e/14f/14g/14h> من docs/features/14-installments.md،
مع مراعاة الناقص المكتوب في docs/FRONTEND_REVIEW.md القسم 3. اعرض الخطة الأول.
```

**F10 — Strings to ARB + small cleanups (section 4)**
```
نفّذ القسم 4 من docs/FRONTEND_REVIEW.md: انقل النصوص الثابتة لملفات ARB، شيل الـ ALTER TABLE
من beforeOpen، ضيف قفل بعد 5 محاولات PIN غلط، وضيف custom_lint.log لـ .gitignore.
متغيّرش أي سلوك تاني. اعرض الخطة الأول.
```

**F11 — Offers broadcaster**
```
نفّذ docs/features/18-offers-broadcaster.md. اعرض الخطة الأول.
```

**F12 — Final check**
```
شغّل flutter analyze و flutter test، وراجع كل البنود في docs/FRONTEND_REVIEW.md.
اعملي جدول: البند / اتصلح / لسه. متعدّلش حاجة.
```

After F12, continue with **A7 (release build)** in `docs/PROMPTS.md`, test with real shops, then Part B.
