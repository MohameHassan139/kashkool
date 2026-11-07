# 01 — Project Setup

**Phase:** 1 · **Tier:** — · **Depends on:** nothing

## Goal
A clean, runnable Flutter skeleton that every later feature plugs into.

## Tasks
1. `flutter create --org com.kashkool --platforms android,ios kashkool`
2. Add packages: `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`,
   `build_runner`, `drift`, `drift_flutter`, `sqlite3_flutter_libs`, `path_provider`,
   `go_router`, `uuid`, `intl`, `flutter_localizations`, `google_fonts` (or bundled font).
3. Folder structure as in `AGENTS.md`.
4. **Theme** (`core/theme/`):
   - Material 3, light + dark.
   - Font: Cairo (bundle it in `assets/fonts/` so it works offline).
   - Semantic colors: `debtRed`, `paymentGreen`, `warningAmber`, `neutralGrey`.
   - Large text scale defaults; min touch target 56dp.
5. **Localization**: `l10n.yaml`, `lib/l10n/app_ar.arb`, `app_en.arb`. Default locale `ar`,
   app forced RTL when locale is Arabic.
6. **Database** (`core/db/app_database.dart`): Drift database with a `schemaVersion`
   and a migration strategy stub. Base mixin for `id/createdAt/updatedAt/deletedAt`.
7. **Router** (`core/router/`): go_router with a bottom navigation shell:
   - `العملاء` (Customers) · `التحصيل` (Collection) · `الموردين` (Suppliers) · `الدرج` (Cash) · `الإعدادات` (Settings)
   - Placeholder screens for each.
8. **Money utils** (`core/utils/money.dart`): `int toPiasters(String)`, `String formatMoney(int)`.
9. **Phone utils** (`core/utils/phone.dart`): validate Egyptian mobile, `toWhatsAppFormat()`.
10. Lints: `flutter_lints` + stricter rules in `analysis_options.yaml`.

## Acceptance Criteria
- [ ] App runs on Android emulator and a real device.
- [ ] UI is RTL Arabic with Cairo font, works offline.
- [ ] Bottom nav switches between 5 placeholder screens.
- [ ] Light/dark mode follows system.
- [ ] Unit tests pass for money and phone utils (incl. edge cases: `"12.5"`, `"1,000"`, invalid phones).
- [ ] `flutter analyze` shows zero issues.
