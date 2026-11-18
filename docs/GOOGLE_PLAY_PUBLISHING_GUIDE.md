# دليل نشر تطبيق كشكول على Google Play (Google Play Publishing Guide)

هذا الدليل يوضح كل الخطوات العملية والإجابات النموذجية لنماذج **Google Play Console** لتجنب أي رفض (Rejection) أو تعليق للتطبيق.

---

## 1. إنشاء مفتاح التوقيع (Release Keystore)

جوجل بلاي يرفض ملفات الـ Debug. يجب إنشاء مفتاح توقيع مشفر:

### أ) توليد ملف المفتاح (Keystore)
شغل هذا الأمر في موجه الأوامر (PowerShell / Terminal):

```bash
keytool -genkey -v -keystore android/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
*سيطلب منك إدخال كلمة سر (احفظها جيداً) وبعض البيانات الأساسية (اسمك/مؤسستك).*

### ب) إنشاء ملف `android/key.properties`
قم بنسخ ملف `android/key.properties.example` إلى `android/key.properties`، واكتب البيانات:

```properties
storePassword=كلمة_السر_التي_اخترتها
keyPassword=كلمة_السر_التي_اخترتها
keyAlias=upload
storeFile=upload-keystore.jks
```
*(تمت إضافة هذه الملفات إلى `.gitignore` تلقائياً لحمايتها من الرفع على GitHub).*

---

## 2. بناء ملف الرفع (App Bundle)

قم بتشغيل الأمر التالي لإنشاء ملف الـ AAB المحسن لمتجر جوجل بلاي:

```bash
flutter build appbundle --release
```

الملف الناتج سيكون في المسار:
`build/app/outputs/bundle/release/app-release.aab`

---

## 3. إجابات استبيانات Google Play Console الإلزامية

### أ) ميزة الخدمات المالية (Financial Features / Personal Loans Policy) ⚠️ *(حرج جداً)*
* **السؤال:** هل يقدم التطبيق قروضاً أو خدمات مصرفية أو تمويل استهلاكي؟
* **الإجابة:** **لا (NO)**.
* **التصنيف:** اختر **Accounting / Bookkeeping Tool (أداة دفاتر ومحاسبة تجارية)**.
* **المبرر:** التطبيق أداة إلكترونية لدفاتر المحلات والتجار (Shopkeeper ledger) لتسجيل الحسابات والديون التجارية البينية مع الزبائن والموردين، ولا يقوم بتقديم أي خدمات إقراض أو تمويل مالي أو دفع بنكي.

### ب) أمان البيانات (Data Safety Questionnaire)
| نوع البيانات | هل يتم جمعها؟ | الغرض والخصائص |
| :--- | :--- | :--- |
| **الصوت (Audio / Voice)** | نعم (اختياري) | يُستخدم للإملاء الصوتي السريع (Speech-to-Text). حدد: **Ephemeral (مؤقت لا يتم حفظه على خوادم)** ولغرض **App Functionality**. |
| **الصور (Photos / Media)** | نعم (اختياري) | لتمكين التاجر من التقاط أو إرفاق صور فواتير أو إيصالات. حدد: **App Functionality**. |
| **المعلومات المالية (Financial Info)** | نعم | مبالغ معاملات دفتر الحسابات (Ledger transactions). حدد: **App Functionality / Account Management**. |
| **بيانات الاتصال (Name / Phone)** | نعم | اسم ورقم هاتف العميل للتواصل عبر واتساب/SMS. حدد: **App Functionality**. |
| **معرفات الحساب (Account Info)** | نعم | البريد الإلكتروني في حال تسجيل الدخول بحساب Google للنسخ السحابي. |
| **معرف الجهاز (Device ID)** | نعم | لتعريف الجهاز لمزامنة البيانات المحلية ومنع تكرار المعاملات. |

> **ملاحظة هامة:** حدد دائماً أن **البيانات مشفرة أثناء النقل (Transferred over secure HTTPS/TLS)**، وأنه **يوجد آلية للمستخدم لطلب حذف البيانات**.

---

## 4. روابط سياسة الخصوصية وحذف الحساب (Mandatory URLs)

قم برفع ملفات HTML الجاهزة الموجودة في `docs/legal/` على موقعك أو استضافة مجانية (GitHub Pages / Firebase Hosting):

1. **رابط سياسة الخصوصية (Privacy Policy URL):**
   * ارفع `docs/legal/privacy-policy.html`
   * ضعه في خانة: **App Content -> Privacy Policy**.
2. **رابط طلب حذف الحساب (Delete Account URL):**
   * ارفع `docs/legal/delete-account.html`
   * ضعه في خانة: **App Content -> Data Safety -> Account Deletion URL**.

---

## 5. ضبط تسجيل الدخول بجوجل (Google Sign-In + Play App Signing)

جوجل بلاي يقوم بإعادة توقيع التطبيق بمفتاح حماية خاص به. لتشغيل ميزة تسجيل الدخول السحابي بـ Google دون أخطاء:

1. بعد رفع أول ملف `.aab` على Play Console.
2. اذهب إلى: **Release** -> **Setup** -> **App Signing**.
3. انسخ قيمة **SHA-1 certificate fingerprint**.
4. افتح **Google Cloud Console** (أو Firebase Console) الخاص بمشروع تسجيل الدخول.
5. في قسم **OAuth 2.0 Client IDs (Android)**، تأكد من إضافة الـ **SHA-1** الخاص بجوجل بلاي، بالإضافة للـ SHA-1 الخاص بمفتاحك المحلي (`upload-keystore.jks`).

---

## 6. شرط الـ 20 مختبر (للحسابات الشخصية الجديدة بعد نوفمبر 2023)

إذا كان حساب المطور الخاص بك شخصياً وجديداً:
1. أنشئ مسار اختبار مغلق (**Closed Testing track**).
2. قم بإضافة إيميلات 20 مختبراً على الأقل (أصدقاء / زملاء / عملاء محلات).
3. يجب أن يقوم المختبرون بتحميل التطبيق وإبقائه على هواتفهم لمدة **14 يوماً متواصلة**.
4. بعد انقضاء الـ 14 يوماً، سيظهر لك زر **Apply for Production** للتقديم على النشر العام على المتجر.
