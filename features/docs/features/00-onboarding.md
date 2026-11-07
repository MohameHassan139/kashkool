# 00 — Onboarding & Shop Personalization (تهيئة المحل لأول مرة)

**Phase:** 1 · **Tier:** Free · **Depends on:** 01 (Project setup)

## User story
As a newly installed shop owner, I want a fast, respectful 60-second onboarding wizard to set my shop name, phone, and business type, understand why notifications and background permissions are critical, and customize which features appear on my home screen so the app fits my exact trade.

---

## 1. Data model

### `shops`
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 (Primary Key) |
| name | text | Required (2–80 chars, e.g. "بقالة الأمانة", "محل النجم للموبايل") |
| shopType | enum | `grocery` \| `mobile` \| `electronics` \| `pharmacy` \| `other` |
| phone | text? | Optional contact / shop phone (Egyptian format `01XXXXXXXXX`) |
| address | text? | Optional shop location / landmark |
| currency | text | Default `EGP` (ج.م) |
| enableInstallments | bool | Auto-set based on `shopType` (true for mobile/electronics; false for grocery/pharmacy; editable) |
| createdAt | datetime | UTC |
| updatedAt | datetime | UTC |
| deletedAt | datetime? | Soft delete |

### Local device & settings linkage
- Creates the first local `shops` record and stores `activeShopId` in `settings`.
- Generates and persists a unique `deviceId` (UUID v4) and `shopCode` (6-char referral code).

---

## 2. Onboarding flow & screens

### Step 1: Shop identity (هوية المحل)
- **Shop name**: Required field with large Cairo font and friendly hint ("اسم المحل أو الكشكول").
- **Shop phone**: Optional, auto-fills default for WhatsApp message footers.

### Step 2: Shop trade / type (نوع النشاط)
Presents 5 clear visual cards with touch targets $\ge 56$dp:
1. 🛒 **بقالة وسوبرماركت (Grocery)**: Focuses on quick daily credit and drawer closing.
2. 📱 **موبايلات وإكسسوارات (Mobile & Accessories)**: **Toggles on Installments tab (الأقساط)** and IMEI fields.
3. ⚡ **أجهزة كهربائية وإلكترونيات (Electronics & Appliances)**: **Toggles on Installments tab (الأقساط)** and contract attachments.
4. 💊 **صيدلية ومستحضرات (Pharmacy)**: Focuses on customer credit limit and prescription debt.
5. 🏪 **أنشطة وتجارة أخرى (Other)**: Flexible default with full customization.

> [!NOTE]
> When `mobile` or `electronics` is selected, the bottom navigation or quick shortcuts immediately activate the **الأقساط (Installments)** entry point. For other types, installments remains accessible via Settings without cluttering the main bar.

### Step 3: Reliable notifications & battery survival (التذكيرات وضمان عمل الإشعارات)
1. **Notification permission**:
   - Prompts system notification permission on Android 13+ with an Egyptian Arabic explanation:
     *"محتاجين إذن الإشعارات عشان نفكرك يومياً بالفلوس اللي ليك ومواعيد الأقساط"*.
2. **Aggressive battery management guide (دليل حماية التطبيق من الإغلاق في الخلفية)**:
   - Crucial for Egyptian popular brands: **Xiaomi (MIUI/HyperOS)**, **Oppo/Realme (ColorOS)**, **Transsion (Infinix, Tecno, Itel)**, and **Samsung**.
   - Clear visual step-by-step illustrations:
     - Enable **Auto-start / التشغيل التلقائي**.
     - Set Battery Saver to **No Restrictions / بلا قيود**.
     - Lock the app in Recent Apps / تثبيت التطبيق في شاشة التطبيقات المفتوحة.
   - Button: *"افتح إعدادات البطارية بالجهاز"* linking via `package_info` / `device_info` intent to native battery settings.

### Step 4: First action (ابدأ أول خطوة)
- Choice of:
  - **"+ ضيف أول عميل"**: Directly opens 02 Add Customer.
  - **"جرب ببيانات تجريبية"**: Seeds 2 dummy customers with a debt and payment so the user instantly sees how the app works, with a 1-tap button to clear test data.
  - **"تخطي إلى الرئيسية"**: Lands on the Customers tab.

---

## 3. Business rules
- Onboarding runs only once (flag `onboardingCompleted = true` in local DB).
- Can re-run or edit shop profile and trade type anytime from `Settings → بيانات المحل`.
- Changing `shopType` updates feature visibility toggles dynamically without reloading the app.

---

## 4. Acceptance Criteria
- [ ] Wizard completes in $\le 4$ steps and persists `shops` record into SQLCipher Drift DB.
- [ ] Selecting Mobile or Electronics activates installments navigation throughout the app.
- [ ] Notification permission requested with localized rationales.
- [ ] Battery guide shows tailored tips matching device manufacturer (`android_id` / `device_info_plus`).
- [ ] Skip and completed flags survive process termination.
- [ ] Tested offline without network connectivity.
