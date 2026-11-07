# Antigravity Prompts — Kashkool

> Written for the **current state** of the project (Nov 2026): Phase 1 features and a large part
> of installments already exist in `lib/`. So Part A is **audit → fix → finish**, not "build from zero".

## Rules for every step
1. Copy **one prompt** at a time.
2. The agent shows a plan → you read it → approve.
3. Run the app on a real Android phone and try the feature yourself.
4. `flutter analyze` and `flutter test` must pass.
5. Commit: `git add . && git commit -m "<step name>"`.

If the conversation gets long or the agent starts forgetting → open a **new conversation** and use
the **Restart** prompt at the bottom.

---

## Part A — Frontend (Flutter app, local only — no backend code)

### A0 — Kickoff & status audit
```
اقرا AGENTS.md و docs/features/README.md. بعدين بص على الكود في lib/ و test/.
اعملي جدول لكل ميزة من 00 لحد 22: (اتنفذت كاملة / ناقصة / مش موجودة)، ولو ناقصة
اكتب إيه الناقص مقارنةً بالـ Acceptance Criteria في ملفها. متعدّلش أي كود.
```

### A1 — Dependencies health check
```
راجع pubspec.yaml:
1) المشروع فيه sqlite3_flutter_libs و sqlcipher_flutter_libs مع بعض، والـ sqlcipher نسخته
   مكتوب عليها eol. شوف الطريقة الصح الحالية في توثيق drift لاستخدام SQLCipher، واتأكد إن
   الداتابيز متشفرة فعلاً على أندرويد.
2) workmanager مش موجود، رغم إن AGENTS.md بيقول نستخدمه للتذكير اليومي. اشرحلي التذكير
   اليومي شغال إزاي دلوقتي، وهل بيحسب عدد العملاء المستحقين وقت الإشعار ولا لأ.
اعرض الخطة والتعديلات المقترحة الأول واستنى موافقتي.
```

### A2 — Crash reporting
```
نفّذ جزء Sentry من docs/features/21-crash-analytics.md. الـ analytics events اعملها
interface فاضي دلوقتي ونوصّله في Part B. اتأكد إن مفيش أي بيانات عملاء بتتبعت. اعرض الخطة الأول.
```

### A3 — Fix gaps from A0 (repeat per feature)
Take the A0 table and, for each feature marked "ناقصة", send:
```
كمّل الناقص في docs/features/<رقم واسم الملف> حسب الجدول اللي عملته في A0.
اعرض الخطة الأول.
```
Suggested order: 00 → 03 → 07 → 12 → 08 → 09 → 10 → 11.

### A4 — Installments: finish remaining milestones
```
اقرا docs/features/14-installments.md وقارنه بالكود في lib/features/installments.
قولّي أنهي milestones من 14a لحد 14h خلصت وأنهي لأ. متعدّلش حاجة.
```
Then for each missing milestone (likely: postpone/reschedule + events log, attachments,
contract/receipt PDFs, reports):
```
نفّذ milestone <14x> من docs/features/14-installments.md. اعرض الخطة الأول.
```
Leave **14i** (paywall + employees) for Part B.

### A5 — Offers broadcaster
```
نفّذ docs/features/18-offers-broadcaster.md (بالـ URL launcher، من غير أي backend). اعرض الخطة الأول.
```

### A6 — Final frontend review ✅
```
راجع المشروع كله مقابل Acceptance Criteria لكل ملفات Phase 1 وملف 14 وملف 18.
اعملي جدول: الميزة / تمام / ناقص إيه. وشغّل flutter analyze و flutter test وقولّي النتيجة.
متعدّلش حاجة.
```

### A7 — Release build for field testing
```
جهّزلي release APK للتجربة: app name "كشكول"، أيقونة مؤقتة، signing config بملف key.properties
(متحطش الباسوردات في git)، و versionCode 1. اشرحلي الخطوات اللي هعملها بإيدي.
```
➡️ **Stop here.** Install on 20–30 shop owners' phones for 2–4 weeks. Fix what they complain
about (use the "Bug" prompt). Start Part B only when shops use the app daily.

---

## Part B — Backend (Supabase + PowerSync)

Before B1 you do these yourself (not the agent):
- Create 2 Supabase projects, `kashkool-dev` and `kashkool-prod`, in **Frankfurt (eu-central-1)**.
- Create a PowerSync account and connect it to the dev project.
- Put the dev URL + **anon key only** in `.env` (add `.env` to `.gitignore`).
  **Never** put the service-role key in the app.

### B0 — Read the architecture
```
اقرا docs/backend/ARCHITECTURE.md و docs/features/13-cloud-sync.md. لخّصلي الخطة واسألني
على أي حاجة مش واضحة. متكتبش كود.
```

### B1 — Schema + RLS
```
جهّز فولدر supabase/ في المشروع (Supabase CLI): migrations لكل الجداول حسب ARCHITECTURE.md
بنفس أعمدة جداول Drift، مع RLS على كل جدول، ودوال is_member و has_perm، و trigger
لـ server_updated_at. اكتب SQL tests إن محل A ميقدرش يقرا أو يكتب بيانات محل B.
اعرض الخطة الأول.
```

### B2 — Google Sign-In
```
نفّذ تسجيل الدخول بحساب جوجل مع Supabase Auth حسب 13-cloud-sync.md. التطبيق لازم يفضل
شغال بالكامل من غير تسجيل دخول. اعرض الخطة الأول.
```

### B3 — PowerSync sync
```
نفّذ المزامنة بـ PowerSync حسب 13-cloud-sync.md: sync rules لكل shop، رفع البيانات المحلية
أول مرة، وشاشة حالة المزامنة. القيم المحسوبة (الأرصدة، paidPiasters، الحالات) متتزامنش.
اتأكد إن ده شغال مع تشفير SQLCipher. اعرض الخطة الأول.
```

### B4 — Photos to Storage
```
ارفع الصور (العمليات والأقساط) على Supabase Storage حسب 13-cloud-sync.md، على الواي فاي بس
افتراضياً. اعرض الخطة الأول.
```

### B5 — Subscriptions + installments gating
```
نفّذ docs/features/16-subscription-paywall.md: Google Play Billing، و Edge Functions
verify-play-purchase و play-rtdn-webhook، وقفل المميزات حسب الباقة. وبعدها milestone 14i
من ملف الأقساط. اعرض الخطة الأول.
```

### B6 — Employees
```
نفّذ docs/features/15-employee-permissions.md. الصلاحيات تتطبق في RLS مش في الـ UI بس.
اعرض الخطة الأول.
```

### B7 — Statement link
```
نفّذ docs/features/20-statement-link.md. اعرض الخطة الأول.
```

### B8 — Referral program
```
نفّذ docs/features/19-referral-program.md مع Edge Function referral-qualify كـ cron يومي.
اعرض الخطة الأول.
```

### B9 — Analytics + remote config
```
وصّل الـ analytics interface اللي عملناه في A2 بـ PostHog حسب 21-crash-analytics.md، ونفّذ
Edge Function remote-config (feature flags + أقل نسخة مسموحة). اعرض الخطة الأول.
```

### B10 — Admin dashboard
```
نفّذ docs/features/22-admin-dashboard.md كمشروع ويب منفصل في فولدر admin/. اعرض الخطة الأول.
```

### B11 — Notebook import (AI)
```
نفّذ docs/features/17-notebook-import.md. اعرض الخطة الأول.
```

### B12 — Security review before launch
```
راجع الـ backend كله مقابل "Security checklist" في docs/backend/ARCHITECTURE.md، واختبر إن
كل جدول عليه RLS. اعملي جدول بالنتيجة ومتعدّلش حاجة.
```

---

## Useful prompts anytime

**Restart (new conversation):**
```
اقرا AGENTS.md و docs/PROMPTS.md. إحنا خلصنا لحد الخطوة <رقمها>.
بص على الكود ولخّصلي حالته في 5 سطور، وبعدين استنى.
```

**Bug:**
```
فيه مشكلة: <اوصف اللي حصل>. الـ error: <الصق الرسالة>.
دوّر على السبب واشرحه الأول قبل ما تعدّل.
```

**Agent did something not in the spec:**
```
ده مش في الـ spec. ارجع للي مكتوب في docs/features/<الملف> بالظبط.
```

**Small UI change:**
```
في شاشة <اسمها>: <التعديل>. متغيّرش أي حاجة تانية.
```
