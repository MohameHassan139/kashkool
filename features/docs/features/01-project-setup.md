# 01 — Project Setup & Core Foundation

**Phase:** 1 · **Tier:** — · **Depends on:** nothing

## Goal
A clean, runnable Flutter skeleton that every later feature plugs into, with local SQLCipher encryption and sync-ready schema metadata.

## Tasks
1. `flutter create --org com.kashkool --platforms android,ios kashkool`
2. Add packages:
   - State & Architecture: `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`, `build_runner`, `go_router`, `uuid`, `intl`.
   - Local Encrypted DB: `drift`, `drift_flutter`, `sqlcipher_flutter_libs`, `sqlite3`, `path_provider`, `flutter_secure_storage`.
   - UI & Theme: `google_fonts` (or bundled Cairo font in `assets/fonts/`), `cupertino_icons`.
   - Device & Utilities: `package_info_plus`, `device_info_plus`, `crypto`.
3. Folder structure as in `AGENTS.md`.
4. **Theme** (`core/theme/`):
   - Material 3, light + dark.
   - Font: Cairo (bundled in `assets/fonts/cairo/` so it works offline forever).
   - Semantic colors: `debtRed` (`#D32F2F`), `paymentGreen` (`#2E7D32`), `warningAmber` (`#F57C00`), `neutralGrey` (`#757575`), `primaryBlue` (`#1976D2`).
   - Large text scale defaults; min touch target 56dp for primary actions.
5. **Localization**: `l10n.yaml`, `lib/l10n/app_ar.arb`, `app_en.arb`. Default locale `ar`, app forced RTL when locale is Arabic.
6. **Encrypted Database** (`core/db/app_database.dart`):
   - Drift database opening with **SQLCipher** encryption key managed via `flutter_secure_storage`.
   - If no key exists in secure storage, generate a cryptographically random 256-bit passphrase, store it, and use it to open the database.
   - **Base Mixin / Table Template**:
     Every table includes:
     - `id`: Text (UUID v4)
     - `shopId`: Text (UUID v4)
     - `deviceId`: Text (device hardware UUID)
     - `createdBy`: Text (user/device identifier)
     - `createdAt`: DateTime (UTC)
     - `updatedAt`: DateTime (UTC)
     - `deletedAt`: DateTime? (nullable UTC for soft delete)
   - Initial tables: `shops`, `settings`.
7. **Router** (`core/router/`): `go_router` with bottom navigation shell:
   - `العملاء` (Customers) · `التحصيل` (Collection) · `الموردين` (Suppliers) · `الدرج` (Cash) · `الإعدادات` (Settings)
   - Dynamic visibility for `الأقساط` (Installments) based on shop type selected during onboarding.
8. **Money utils** (`core/utils/money.dart`): `int toPiasters(String)`, `String formatMoney(int)`. 1 EGP = 100 piasters.
9. **Phone utils** (`core/utils/phone.dart`): validate Egyptian mobile (`010`, `011`, `012`, `015`), normalize Arabic-Indic digits, convert to WhatsApp format (`201XXXXXXXXX`).
10. Lints: `flutter_lints` + stricter rules in `analysis_options.yaml`.

## Acceptance Criteria
- [ ] App runs on Android emulator and physical device without crash.
- [ ] UI is RTL Arabic with Cairo font, works offline.
- [ ] Drift DB is encrypted via SQLCipher; raw inspection of sqlite file shows random cipher bytes.
- [ ] All table definitions inherit `shopId`, `deviceId`, `createdBy`, `createdAt`, `updatedAt`, `deletedAt`.
- [ ] Unit tests pass for money and phone utils (incl. edge cases: `"12.5"`, `"1,000"`, invalid phones, Arabic digits).
- [ ] `flutter analyze` shows zero issues.
