# 12 — Settings, Security, Battery Guide & Local Backup

**Phase:** 1 · **Tier:** Free · **Depends on:** 00, 01

## Structure & Build Ordering
To ensure foundational features like 02 (Customers) and 07 (Daily Collection) function smoothly from day one, Settings is split into two logical layers:
- **Layer 1: Basic Shop Setup & Preferences** (Built early: shop profile, payment handles, reminder schedule, message templates, default credit limit).
- **Layer 2: Advanced Security, Battery Optimization & Local Backup** (App lock, SQLCipher encryption verification, OEM battery guide, privacy mode, and `.kashkool` zip export).

---

## 1. Sections & Content

### 🏢 بيانات المحل (Shop Info) — Layer 1
- **اسم المحل**: Shop display name.
- **رقم الهاتف**: Shop contact phone.
- **نوع النشاط**: Trade selector (بقالة، موبايلات، أجهزة، صيدلية، أخرى) — toggles installments engine.
- **العنوان**: Shop address / district.
- **بيانات الدفع الإلكتروني**:
  - InstaPay username / handle (e.g. `shop@instapay`).
  - Mobile wallet number (Vodafone Cash, Orange Money, etc.).
  - Bank account details (optional).

### 🔔 إعدادات التذكيرات والتحصيل (Collection & Reminders) — Layer 1
- **ميعاد التذكير اليومي**: Time picker (default 10:00 AM).
- **الحد الأدنى لعمر الدين (`minDebtAgeDays`)**: Default 3 days.
- **فترة التذكير بين المرات (`reminderIntervalDays`)**: Default 7 days.
- **محرر قوالب الرسائل**:
  - Template selection: ودّي (Friendly) · رسمي (Formal) · مخصص (Custom).
  - Chip placeholders insertable with 1-tap (`{customer_name}`, `{shop_name}`, `{balance}`, etc.).
  - Live interactive preview with sample customer figures.

### 🛡️ الحماية والأمان (Security & App Lock) — Layer 2
- **تشفير قاعدة البيانات**: Built-in SQLCipher 256-bit AES encryption with device key in Android Keystore / iOS Keychain.
- **قفل التطبيق (App Lock)**:
  - Fingerprint / Face ID via `local_auth` (`FlutterFragmentActivity` on Android).
  - 4-digit PIN fallback with salted SHA-256 hash.
  - Auto-lock timeout selector: فوراً عند الخروج (0 min) · بعد دقيقة · بعد 5 دقائق · بعد 15 دقيقة.
  - Recent apps screen shield (shows privacy blank screen with lock icon in app switcher).
- **وضع الخصوصية (Privacy Mode)**:
  - Toggle from Settings or AppBar eye icon.
  - Masks all amounts with bullet dots (`•••• ج.م`) to protect shop financial privacy in front of walk-in customers.

### 🔋 دليل البطارية ومصنّعي الهواتف (Battery Optimization Guide) — Layer 2
Dedicated troubleshooting screen tailored for aggressive background app-killing OEMs:
- Detects device manufacturer (`Infinix`, `Tecno`, `Xiaomi`, `Oppo`, `Realme`, `Samsung`, `Huawei`).
- Explains why background killing prevents daily morning collection notifications.
- Provides direct deep link button to device settings:
  - Step 1: تفعيل التشغيل التلقائي (Auto-start).
  - Step 2: ضبط استهلاك البطارية على "بلا قيود" (No restrictions / Don't optimize).
  - Step 3: قفل التطبيق في قائمة التطبيقات الأخيرة (Lock in Recents).

### 📦 النسخ الاحتياطي اليدوي (Local Backup File) — Layer 2
- **تصدير نسخة احتياطية (.kashkool)**:
  - Exports encrypted SQLite database + photo attachments into a single compressed `.kashkool` (ZIP) archive.
  - Opens native share sheet via `share_plus` to save to Google Drive, WhatsApp, Telegram, or device storage.
- **استعادة نسخة احتياطية**:
  - File picker (`file_picker`) accepts `.kashkool` files.
  - Comprehensive integrity validation: checks SQLite header magic bytes, verifies table schemas, validates photo count.
  - Confirmation dialog with warning: "استعادة النسخة ستستبدل كل البيانات الحالية".
- **تذكير دوري**:
  - Banner every 7 days if no export was performed: "لم تقم بعمل نسخة احتياطية منذ 7 أيام — احفظ بياناتك الآن".

### ⚖️ الخصوصية والشروط والقانون المصري (Privacy & Legal) — Layer 2
- **قانون حماية البيانات الشخصية المصري (رقم 151 لسنة 2020)**:
  - All customer and guarantor National ID fields are strictly **optional**.
  - Customer data is stored locally first on the merchant's encrypted device.
  - Transparent Privacy Policy explaining that data is used solely for shop debt ledger accounting.
  - In-app link to readable Privacy Policy and Terms of Service.
  - Right to erasure: deleting a customer or clearing the database purges all records.

---

## Acceptance Criteria
- [ ] Shop info, reminder settings, and template updates persist across app restarts.
- [ ] Database is encrypted with SQLCipher; unreadable by external SQLite tools without key.
- [ ] Biometric and PIN authentication unlock reliably without infinite prompt loops.
- [ ] Battery optimization guide accurately identifies device brand and launches intent.
- [ ] Export produces a valid `.kashkool` archive; import validates and restores fully.
- [ ] Corrupted or invalid backup files fail safely without modifying current database.
