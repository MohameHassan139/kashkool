# 21 — Crash Reporting & Privacy-Friendly Analytics (مراقبة الأعطال وإحصائيات الأداء)

**Phase:** 2 · **Tier:** System Infrastructure · **Depends on:** 01 Project Setup

## Goal
Ensure application stability across hundreds of Android device models used in Egypt (Infinix, Tecno, Xiaomi, Samsung, Oppo, Realme) with real-time error tracking and privacy-respecting product metrics, without collecting any customer personal data or shop trade secrets.

---

## 1. Crash Reporting (Sentry / Firebase Crashlytics)

### Technical Setup
- Integration via official Flutter SDK (`sentry_flutter` or `firebase_crashlytics`).
- Automatic unhandled exception capture, Flutter widget error handling (`FlutterError.onError`), and platform channel crash reporting.
- ProGuard / R8 mapping file upload and debug symbol demangling automated via CI/CD.

### Diagnostic Breadcrumbs Captured
- App lifecycle state changes (`resumed`, `paused`, `hidden`).
- Router navigation events (e.g. `Navigated to /installments/new`).
- Database migration triggers.
- Network connectivity transitions (Wi-Fi ↔ Cellular ↔ Offline).
- Device hardware specs (OS version, brand, free RAM, available storage).

---

## 2. Privacy-Friendly Product Analytics

> [!CAUTION]
> **Zero Personal & Financial Data Policy (Egypt Law 151/2020 Compliance)**:
> - **NEVER** transmit customer names, phone numbers, notes, national IDs, or photos.
> - **NEVER** transmit monetary amounts (e.g. whether a debt was 50 EGP or 50,000 EGP).
> - All events identify only the anonymized `shopId` and `deviceId`.

### Core Metrics Tracked
| Metric / Event | Purpose | Payload |
|---|---|---|
| `app_opened` | Daily Active Shops (DAS), Day-1/7/30 Retention | `{ shop_type, is_pro, os_version }` |
| `transaction_recorded` | Core feature adoption & frequency | `{ type: "debt" \| "payment", method: "cash" \| "instapay" }` |
| `customer_created` | Growth of shop notebook size | `{ has_phone: bool, has_limit: bool }` |
| `collection_whatsapp_tapped` | Reminder effectiveness | `{ rating_category: "late" \| "watch" }` |
| `installment_plan_created` | Installments feature usage | `{ frequency: "monthly", count: int }` |
| `paywall_viewed` | Conversion funnel analysis | `{ trigger_source: "installments" \| "sync" }` |
| `backup_exported` | Local data safety behavior | `{ size_kb: int, is_manual: bool }` |

---

## 3. Data Retention & User Controls
- Crash reports retained for 90 days, then permanently deleted.
- Analytics data aggregated for trend analysis.
- Settings → "بيانات الاستخدام المجهولة": Optional user toggle allowing shop owners to opt-out of anonymous usage diagnostics.

---

## Acceptance Criteria
- [ ] Uncaught exceptions report to Sentry/Crashlytics with complete de-obfuscated Dart stack traces.
- [ ] No PII (names, phone numbers, monetary values) appears in any event or breadcrumb log.
- [ ] Works seamlessly offline; error reports and metrics queue locally and batch-send on next connection.
- [ ] Network impact is negligible (< 100 KB daily data usage).
