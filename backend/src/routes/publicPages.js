import { Router } from 'express';
import { config } from '../config.js';

/**
 * Public legal & compliance pages for Google Play:
 *  - /privacy, /privacy-policy      → Privacy Policy URL (Play Console → App Content → Privacy Policy)
 *  - /account/delete, /delete-account → Account Deletion URL (Play Console → App Content → Data Safety)
 *
 * Full compliance with:
 *  - Egyptian Personal Data Protection Law (Law No. 151 of 2020)
 *  - Google Play User Data & Financial Features policies
 *  - Ephemeral Audio (speech-to-text), SQLCipher local-first encryption, and account deletion rights
 */
export const publicPagesRouter = Router();

const esc = (s) => String(s).replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]);

function renderLayout({ title, isDanger = false, contentAr, contentEn }) {
  const email = config.supportEmail || 'mohamedhessan139@gmail.com';
  const primaryColor = isDanger ? '#dc2626' : '#108e68';
  const primaryLight = isDanger ? '#fef2f2' : '#e6f4ea';
  const primaryBorder = isDanger ? '#fecaca' : '#bbf7d0';

  return `<!doctype html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${esc(title)} — كشكول (Kashkool)</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: ${primaryColor};
      --primary-light: ${primaryLight};
      --primary-border: ${primaryBorder};
      --text: #1f2937;
      --text-muted: #4b5563;
      --bg: #f9fafb;
      --card-bg: #ffffff;
      --border: #e5e7eb;
      --table-border: #e2e8f0;
    }
    @media (prefers-color-scheme: dark) {
      :root {
        --text: #f3f4f6;
        --text-muted: #9ca3af;
        --bg: #0b1120;
        --card-bg: #111827;
        --border: #1f293d;
        --table-border: #2d3748;
        --primary-light: rgba(16, 142, 104, 0.15);
        --primary-border: rgba(16, 142, 104, 0.3);
      }
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: 'Cairo', system-ui, -apple-system, sans-serif;
      background: var(--bg);
      color: var(--text);
      line-height: 1.85;
      padding: 24px 16px 80px;
    }
    .container {
      max-width: 900px;
      margin: 0 auto;
      background: var(--card-bg);
      border: 1px solid var(--border);
      border-radius: 24px;
      padding: 48px 40px;
      box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.05), 0 8px 12px -6px rgba(0, 0, 0, 0.02);
    }
    .badge {
      display: inline-block;
      background: var(--primary-light);
      color: var(--primary);
      padding: 6px 16px;
      border-radius: 20px;
      font-weight: 700;
      font-size: 13.5px;
      margin-bottom: 12px;
      border: 1px solid var(--primary-border);
    }
    h1 {
      color: var(--primary);
      font-size: 28px;
      font-weight: 800;
      margin: 0 0 12px;
    }
    h2 {
      font-size: 20px;
      color: var(--text);
      margin-top: 36px;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    h2::before {
      content: "";
      display: inline-block;
      width: 6px;
      height: 22px;
      background: var(--primary);
      border-radius: 4px;
    }
    h3 { font-size: 17.5px; color: var(--text); margin-top: 24px; }
    p, li {
      font-size: 15.5px;
      color: var(--text-muted);
      margin-bottom: 10px;
    }
    ul, ol { padding-right: 24px; }
    .alert-box {
      background: var(--primary-light);
      border-right: 5px solid var(--primary);
      padding: 18px 22px;
      border-radius: 12px;
      margin: 24px 0;
    }
    .alert-box p {
      margin: 0;
      color: var(--text);
      font-weight: 700;
      font-size: 15.5px;
    }
    .table-responsive {
      overflow-x: auto;
      margin: 24px 0;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14.5px;
    }
    th, td {
      padding: 14px 16px;
      border: 1px solid var(--table-border);
      text-align: right;
    }
    th {
      background: var(--primary-light);
      color: var(--primary);
      font-weight: 700;
    }
    .contact-card {
      background: var(--primary-light);
      border: 1px solid var(--primary-border);
      padding: 24px;
      border-radius: 16px;
      margin-top: 36px;
    }
    .contact-card p {
      margin: 4px 0;
      color: var(--text);
      font-weight: 600;
    }
    .en-section {
      direction: ltr;
      text-align: left;
      font-family: 'Inter', system-ui, -apple-system, sans-serif;
      margin-top: 60px;
      padding-top: 48px;
      border-top: 2px dashed var(--border);
    }
    .en-section h2::before { display: none; }
    .en-section h2 { border-left: 5px solid var(--primary); padding-left: 12px; }
    .en-section ul, .en-section ol { padding-left: 24px; padding-right: 0; }
    .en-section th, .en-section td { text-align: left; }
    a { color: var(--primary); text-decoration: underline; }
    a:hover { opacity: 0.85; }
    .form-group { margin-bottom: 20px; }
    label { display: block; font-weight: 700; margin-bottom: 8px; font-size: 15px; }
    input, textarea {
      width: 100%;
      padding: 13px 16px;
      border: 1px solid var(--border);
      background: var(--card-bg);
      color: var(--text);
      border-radius: 12px;
      font-size: 15px;
      font-family: inherit;
      outline: none;
    }
    button {
      background: var(--primary);
      color: #ffffff;
      border: none;
      padding: 15px 28px;
      border-radius: 12px;
      font-size: 16.5px;
      font-weight: 700;
      cursor: pointer;
      width: 100%;
      font-family: inherit;
    }
  </style>
</head>
<body>
<div class="container">
  <span class="badge">Google Play Verified · آخر تحديث: نوفمبر 2026</span>
  <h1>${esc(title)}</h1>
  <div class="ar-section">
    ${contentAr}
  </div>
  <div class="contact-card">
    <h3 style="margin-top: 0; color: var(--primary);">بيانات التواصل ومسؤول حماية البيانات (DPO Contact):</h3>
    <p>📧 البريد الإلكتروني الرسمي: <a href="mailto:${esc(email)}">${esc(email)}</a></p>
    <p>🌐 الموقع الرسمي والخدمات السحابية: <a href="https://backend-gamma-ten-87.vercel.app">https://backend-gamma-ten-87.vercel.app</a></p>
    <p>📍 المقر والتطوير: جمهورية مصر العربية</p>
  </div>
  <div class="en-section">
    ${contentEn}
    <div class="contact-card">
      <h3 style="margin-top: 0; color: var(--primary);">Data Protection Officer & Official Contact:</h3>
      <p>📧 Official Support & DPO Email: <a href="mailto:${esc(email)}">${esc(email)}</a></p>
      <p>🌐 Official Backend: <a href="https://backend-gamma-ten-87.vercel.app">https://backend-gamma-ten-87.vercel.app</a></p>
      <p>📍 Location: Arab Republic of Egypt</p>
    </div>
  </div>
</div>
</body>
</html>`;
}

// 1. Comprehensive Privacy Policy endpoint
publicPagesRouter.get(['/privacy', '/privacy-policy'], (req, res) => {
  res.set('Cache-Control', 'public, max-age=3600');
  res.type('html').send(
    renderLayout({
      title: 'سياسة الخصوصية الشاملة — كشكول (Kashkool Privacy Policy)',
      isDanger: false,
      contentAr: `
        <div class="alert-box">
          <p>⚖️ إقرار صريح بطبيعة التطبيق (Anti-Lending Declaration):</p>
          <p style="font-weight: normal; margin-top: 6px; font-size: 15px;">تطبيق كشكول هو <strong>دفتر حسابات رقمي وأداة محاسبية لأصحاب المحلات والتجار (Bookkeeping & Accounting Ledger)</strong> لتسجيل المعاملات اليومية والديون التجارية البينية مع الزبائن والموردين. <strong>التطبيق ليس منصة قروض، ولا يقدم أي خدمات تمويل شخصي أو استهلاكي، ولا يمنح قروضاً، ولا يخضع لتصنيف المؤسسات المالية المقرضة</strong>.</p>
        </div>

        <h2>1. المبدأ المعماري: أولوية التخزين المحلي المشفر (Local-First Architecture)</h2>
        <p>صُمم تطبيق كشكول ليعمل بالكامل بدون الحاجة لأي اتصال بالإنترنت (Offline-First). وعليه:</p>
        <ul>
          <li>كافة بيانات المعاملات المالية، وأسماء العملاء والموردين، وأرقام هواتفهم، والديون والمستحقات، وحركة الخزينة، تُحفظ مباشرة على الذاكرة الداخلية لجهازك فقط.</li>
          <li>يتم تشفير قاعدة البيانات المحلية بالكامل بتقنية <strong>SQLCipher</strong> المعتمدة على معيار التشفير المتقدم <strong>AES-256 bit</strong> في وضع CBC، مع اشتقاق المفاتيح بأمان عبر <code>flutter_secure_storage</code> داخل معالج الأمان الموثوق (Keystore) الخاص بنظام هاتفك.</li>
          <li>لا يملك فريق العمل أو أي طرف ثالث القدرة على فك تشفير أو الاطلاع على محتويات دفترك المحلي على الإطلاق.</li>
        </ul>

        <h2>2. البيانات التي يتم التعامل معها في التطبيق (Data Collection & Usage)</h2>
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>نوع البيانات / الإذن</th>
                <th>طبيعة المعالجة</th>
                <th>الغرض والخصائص</th>
                <th>المشاركة أو البيع</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><strong>المعاملات المحاسبية (دفتر الحسابات)</strong></td>
                <td>تسجيل محلي مشفر</td>
                <td>تسجيل مبالغ الديون والدفعات ("عليه" و "دفع") وملاحظات البضاعة لإدارة حسابات المحل اليومية وحساب الخزينة.</td>
                <td><strong>لا تُشارك أو تُباع مطلقاً</strong></td>
              </tr>
              <tr>
                <td><strong>بيانات العملاء والموردين</strong></td>
                <td>اختياري بالكامل</td>
                <td>اسم العميل ورقم هاتفه للتواصل وإرسال كشف الحساب عبر WhatsApp أو SMS. الرقم القومي للعميل والضامن هو حقل اختياري بحت ومحمي بقوة القانون 151 لسنة 2020.</td>
                <td><strong>لا تُشارك مع أي جهة خارجية</strong></td>
              </tr>
              <tr>
                <td><strong>الميكروفون (تسجيل الصوت)</strong></td>
                <td>مؤقت ولحظي (Ephemeral)</td>
                <td>يُستخدم حصرياً لميزة <strong>الإملاء الصوتي</strong> (Speech-to-Text) لكتابة ملاحظات المعاملات بصوت التاجر لتسهيل الإدخال السريع أثناء ضغط البيع. لا يتم تسجيل أو حفظ أو رفع أي ملفات صوتية لأي خوادم.</td>
                <td><strong>لا يُخزن ولا يُنقل إطلاقاً</strong></td>
              </tr>
              <tr>
                <td><strong>الكاميرا ومعرض الصور</strong></td>
                <td>اختياري محلي</td>
                <td>لالتقاط صور الفواتير أو إيصالات التوريد أو استيراد صفحات الدفتر الورقي عبر الكاميرا. تظل الصور داخل ذاكرة التطبيق المحلية ولا تُرفع إلى الخوادم السحابية.</td>
                <td><strong>محلي فقط على الجهاز</strong></td>
              </tr>
              <tr>
                <td><strong>حساب Google (البريد والاسم)</strong></td>
                <td>اختياري بحت</td>
                <td>فقط عند رغبة المستخدم في تفعيل ميزة <strong>النسخ الاحتياطي السحابي</strong>، يتم التحقق من الهوية بربط النسخة بحساب Google Sign-In المعتمد لتمكينه من استعادة بياناته على أجهزة أخرى.</td>
                <td><strong>تشفير مشدد لنفس المستخدم فقط</strong></td>
              </tr>
              <tr>
                <td><strong>معرفات الأجهزة (Device IDs)</strong></td>
                <td>أمان ومزامنة</td>
                <td>معرف الجهاز لمنع تكرار أو تصادم أرقام العمليات المحاسبية ولضمان مزامنة دقيقة في حال استخدام عدة هواتف لنفس المحل.</td>
                <td><strong>استخدام داخلي حصري</strong></td>
              </tr>
            </tbody>
          </table>
        </div>

        <h2>3. الأذونات الحساسة لنظام أندرويد (Android Runtime Permissions)</h2>
        <ul>
          <li><strong>إذن الميكروفون (<code>RECORD_AUDIO</code>):</strong> لا يطلب التطبيق هذا الإذن إلا عند نقر التاجر صراحة على زر الميكروفون لإملاء الملاحظات، ويتم تحويل الصوت إلى نص لحظياً على الجهاز دون تسجيل.</li>
          <li><strong>إذن الكاميرا (<code>CAMERA</code>):</strong> يُطلب فقط عند النقر على إرفاق فاتورة أو تصوير صفحة دفتر ورقي.</li>
          <li><strong>إذن الإشعارات (<code>POST_NOTIFICATIONS</code>):</strong> يُطلب على أندرويد 13 فما فوق لتنبيه التاجر بموعد التحصيل وإقفال الخزينة اليومي المحدد مسبقاً من قِبله. تم ضبط التنبيهات لتعمل بنمط ذكي موفر للطاقة دون الحاجة لمنبهات دقيقة قد تضر ببطارية الهاتف.</li>
        </ul>

        <h2>4. سياسة الإعلانات والتتبع الصارمة (Zero-Ads & Anti-Tracking Policy)</h2>
        <p>انطلاقاً من احترام سرية التجارة وحرمة السجلات المالية لأصحاب المحلات:</p>
        <ul>
          <li>تطبيق كشكول <strong>خالٍ تماماً من أي إعلانات (100% Ad-Free)</strong>، ولن يحتوي على أي إعلانات مستقبلاً.</li>
          <li>لا نستخدم أي حزم برمجية للتتبع الإعلاني (No Ad Trackers / No Data Brokers).</li>
          <li>لا نقوم إطلاقاً ببيع أو تأجير أو مقايضة بيانات التجار أو عملائهم أو معاملاتهم مع أي جهات تسويقية أو مالية أو إعلانية.</li>
        </ul>

        <h2>5. معايير الأمان ونقل البيانات السحابية (Security & Encryption in Transit)</h2>
        <p>في حال تفعيل النسخ الاحتياطي السحابي الاختياري:</p>
        <ul>
          <li>يتم تشفير كافة البيانات المنقولة بين هاتفك وخوادم السحابة باستخدام بروتوكولات التشفير الحديثة <strong>TLS 1.3 / HTTPS</strong>.</li>
          <li>تخضع قواعد البيانات السحابية لقواعد صلاحيات مشددة (Row-Level Security) تمنع أي جهاز من الوصول لبيانات محل آخر.</li>
          <li>سجلات المعاملات غير قابلة للتعديل الخفي (Append-Only Audit Trail) للحفاظ على النزاهة المحاسبية ومنع التلاعب.</li>
        </ul>

        <h2>6. حقوق المستخدم وحذف الحساب والبيانات (Account & Data Deletion Rights)</h2>
        <p>التزاماً بسياسات Google Play الصارمة وبموجب القانون المصري، يملك المستخدم السيطرة الكاملة والحق المطلق في طلب محو بياناته بالكامل:</p>
        <ol>
          <li><strong>الحذف الفوري من داخل التطبيق:</strong>
            <br>افتح التطبيق ← الإعدادات ← النسخ السحابي ← اضغط على <strong>"احذف حسابي على السحابة"</strong>. يتم فوراً مسح حسابك وكافة النسخ الاحتياطية المربوطة بمحلك نهائياً وبشكل غير قابل للاسترجاع.
          </li>
          <li><strong>الحذف عبر صفحة الويب الخارجية (في حال إلغاء تثبيت التطبيق):</strong>
            <br>يمكنك طلب حذف حسابك السحابي دون الحاجة لتثبيت التطبيق عبر زيارة رابط الخدمة المخصص: 
            <a href="/account/delete">https://backend-gamma-ten-87.vercel.app/account/delete</a>
            أو إرسال بريد إلكتروني مباشر إلى مسؤول حماية البيانات (<a href="mailto:mohamedhessan139@gmail.com">mohamedhessan139@gmail.com</a>) وسيتم معالجة الطلب ومسح البيانات خلال 48 ساعة كحد أقصى.
          </li>
        </ol>

        <h2>7. حماية خصوصية الأطفال (Children's Privacy)</h2>
        <p>تطبيق كشكول هو أداة تجارية مخصصة لأصحاب الأعمال والمحلات التجارية البالغين فقط، ولا يستهدف أو يجمع عمداً أي بيانات خاصة بالأطفال دون سن 18 عاماً.</p>

        <h2>8. التعديلات والتحديثات على هذه السياسة</h2>
        <p>قد نقوم بتحديث هذه السياسة دورياً لتتوافق مع أي تحديثات قانونية أو متطلبات جديدة لمتجر Google Play. سيتم إشعار المستخدمين بأي تغييرات جوهرية عبر التطبيق أو تحديث تاريخ المراجعة في أعلى الصفحة.</p>
      `,
      contentEn: `
        <span class="badge">Official English Version · Google Play Developer Policies Compliant</span>
        <h1 style="color: var(--primary);">Comprehensive Privacy Policy — Kashkool App</h1>
        <p>This Privacy Policy outlines how <strong>Kashkool</strong> collects, uses, and safeguards your commercial records. It complies with the <strong>Egyptian Personal Data Protection Law (Law No. 151 of 2020)</strong> and the <strong>Google Play Developer Distribution Agreement & User Data Policies</strong>.</p>

        <div class="alert-box">
          <p>⚖️ Explicit Non-Lending Declaration (Anti-Loan Policy Compliance):</p>
          <p style="font-weight: normal; margin-top: 6px; font-size: 15px;">Kashkool is a <strong>digital bookkeeping and merchant accounting ledger</strong> designed for retail store owners to record receivables and debts. <strong>Kashkool is NOT a loan provider, lending app, or credit financing institution, and does NOT offer consumer or personal loans.</strong></p>
        </div>

        <h2>1. Local-First & Military-Grade SQLCipher Encryption</h2>
        <p>Kashkool operates fully offline without requiring an active internet connection:</p>
        <ul>
          <li>All transactions, debts, repayments, customer/supplier names, and phone numbers are stored locally on your device's internal storage.</li>
          <li>The local SQLite database is encrypted with military-grade <strong>SQLCipher (AES-256 bit in CBC mode)</strong>. Master encryption keys are stored securely using hardware-backed platform keystores.</li>
          <li>Neither Kashkool developers nor third parties possess the ability to decrypt or inspect your local bookkeeping records.</li>
        </ul>

        <h2>2. Data Collection and Usage (Data Safety Matrix)</h2>
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>Data Type / Permission</th>
                <th>Processing Scope</th>
                <th>Purpose</th>
                <th>Shared / Sold?</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><strong>Financial Ledger Transactions</strong></td>
                <td>Local encrypted storage</td>
                <td>To record store credit ("عليه") and payments ("دفع") to calculate receivables and daily cash balances.</td>
                <td><strong>Never shared or sold</strong></td>
              </tr>
              <tr>
                <td><strong>Customer Contacts (Name & Phone)</strong></td>
                <td>Optional</td>
                <td>To enable merchant-initiated reminder messages via WhatsApp or SMS. National ID numbers are strictly optional.</td>
                <td><strong>Never shared with third parties</strong></td>
              </tr>
              <tr>
                <td><strong>Microphone (<code>RECORD_AUDIO</code>)</strong></td>
                <td>Ephemeral (In-memory only)</td>
                <td>Exclusively used when the merchant taps the voice input button for speech-to-text dictation of transaction notes. Audio is never recorded, saved, or uploaded.</td>
                <td><strong>Never stored or transmitted</strong></td>
              </tr>
              <tr>
                <td><strong>Camera & Photo Gallery</strong></td>
                <td>Local device access only</td>
                <td>To attach bill receipts, invoices, or photograph physical notebook pages. Pictures remain strictly on the device.</td>
                <td><strong>Device only</strong></td>
              </tr>
              <tr>
                <td><strong>Google Account (Email & Profile Name)</strong></td>
                <td>Optional Cloud Backup</td>
                <td>If cloud backup is activated, Google Sign-In is used solely to authenticate and associate the encrypted backup with your account.</td>
                <td><strong>Protected for owner access only</strong></td>
              </tr>
            </tbody>
          </table>
        </div>

        <h2>3. Strict Zero-Ads and Anti-Brokering Commitment</h2>
        <ul>
          <li>Kashkool is <strong>100% ad-free</strong> with no banner, interstitial, or video advertisements.</li>
          <li>We do not utilize commercial advertising SDKs or tracking technologies.</li>
          <li>We strictly prohibit the sale, lease, or dissemination of user or customer records to data brokers, advertising networks, or financial institutions.</li>
        </ul>

        <h2>4. Account and Cloud Data Deletion (User Control)</h2>
        <p>Users retain full sovereignty over their data:</p>
        <ol>
          <li><strong>Instant In-App Deletion:</strong> Open Kashkool → Settings → Cloud Backup → Tap <em>"Delete my cloud account"</em>. Your account credentials, backup archives, and shop memberships are purged immediately and irrevocably.</li>
          <li><strong>External Web Request:</strong> If you uninstalled the application, request deletion anytime at: <a href="/account/delete">https://backend-gamma-ten-87.vercel.app/account/delete</a> or email our Data Protection Officer directly at <a href="mailto:mohamedhessan139@gmail.com">mohamedhessan139@gmail.com</a>. Requests are completed within 48 hours.</li>
        </ol>

        <h2>5. Security of Cloud Data in Transit</h2>
        <p>All communication with cloud backup infrastructure is secured using modern <strong>TLS 1.3 / HTTPS encryption</strong> with strict Row-Level Security isolation between shops.</p>

        <h2>6. Children's Privacy</h2>
        <p>Kashkool is a business administration tool designed exclusively for adult shop owners and does not knowingly collect information from minors under the age of 18.</p>
      `,
    }),
  );
});

// 2. Comprehensive Account & Data Deletion endpoint
publicPagesRouter.get(['/account/delete', '/delete-account'], (req, res) => {
  res.set('Cache-Control', 'public, max-age=3600');
  res.type('html').send(
    renderLayout({
      title: 'طلب حذف الحساب ونسخ السحابة — كشكول (Account Deletion)',
      isDanger: true,
      contentAr: `
        <div class="alert-box" style="border-right-color: var(--primary);">
          <p>⚠️ <strong>تحذير بشأن الحذف النهائي:</strong> إن إجراء حذف الحساب السحابي هو إجراء نهائي لا رجعة فيه؛ سيتم مسح كافة النسخ الاحتياطية السحابية المربوطة بمحلك وجلسات الدخول نهائياً ولا يمكن استرجاعها.</p>
        </div>

        <div style="background: var(--bg); border: 1px solid var(--border); padding: 24px; border-radius: 14px; margin: 24px 0;">
          <h3 style="margin-top: 0; color: #108e68;">الطريقة الأولى: الحذف الفوري اللحظي من داخل التطبيق (موصى بها)</h3>
          <ol>
            <li>افتح تطبيق <strong>كشكول</strong> على هاتفك المحمول.</li>
            <li>انتقل إلى <strong>الإعدادات</strong> (أيقونة الترس في أسفل الشاشة أو تبويب المزيد).</li>
            <li>اضغط على قسم <strong>"النسخ السحابي"</strong>.</li>
            <li>انزل لأسفل واضغط على <strong>"احذف حسابي على السحابة"</strong>.</li>
            <li>أكد العملية في نافذة التأكيد؛ وسيتم فوراً وبشكل لحظي محو حسابك وجميع نسخ محلاتك السحابية من الخادم.</li>
          </ol>
        </div>

        <div style="background: var(--card-bg); border: 1px solid var(--primary-border); padding: 24px; border-radius: 14px; margin: 24px 0;">
          <h3 style="color: var(--primary); margin-top: 0;">الطريقة الثانية: تقديم طلب حذف إلكتروني (في حال قمت بحذف التطبيق مسبقاً)</h3>
          <p style="font-size: 14.5px; color: var(--text-muted); margin-bottom: 16px;">
            إذا كنت قد حذفت التطبيق من هاتفك وترغب في التأكد من محو بياناتك من خوادم السحابة، يرجى تعبئة النموذج أدناه وسيتم إرسال الطلب ومعالجته ومحو السجلات نهائياً خلال <strong>48 ساعة كحد أقصى</strong>:
          </p>

          <form action="mailto:mohamedhessan139@gmail.com?subject=Account%20and%20Data%20Deletion%20Request%20-%20Kashkool" method="POST" enctype="text/plain">
            <div class="form-group">
              <label for="email">البريد الإلكتروني المسجل في التطبيق (Google Account Email):</label>
              <input type="email" id="email" name="email" required placeholder="example@gmail.com">
            </div>
            <div class="form-group">
              <label for="shop">اسم المحل أو رقم الهاتف المسجل به (لتأكيد الملكية):</label>
              <input type="text" id="shop" name="shop_name" placeholder="اسم المحل أو رقم الهاتف">
            </div>
            <div class="form-group">
              <label for="reason">ملاحظات إضافية أو سبب الحذف (اختياري):</label>
              <textarea id="reason" name="reason" rows="3" placeholder="اكتب أي ملاحظة إن وُجدت..."></textarea>
            </div>
            <button type="submit">إرسال طلب الحذف إلى مسؤول حماية البيانات</button>
          </form>
        </div>

        <div style="margin-top: 36px; border-top: 1px solid var(--border); padding-top: 24px;">
          <h3 style="font-size: 17.5px; margin-bottom: 8px;">ما الذي يتم حذفه تحديداً؟</h3>
          <p>يتم حذف عنوان بريدك الإلكتروني، واسمك، وجلسات المصادقة (Tokens)، وجميع النسخ الاحتياطية لدفتر الحسابات والديون الخاصة بالمحلات التي تملكها والمخزنة على خوادم السحابة نهائياً.</p>

          <h3 style="font-size: 17.5px; margin-bottom: 8px;">ماذا عن البيانات الموجودة داخل الهاتف؟</h3>
          <p>بما أن كشكول تطبيق يعتمد على التخزين المحلي أولاً (Local-First)، فإن بيانات الهاتف تظل على ذاكرة جهازك المشفرة. لحذفها بالكامل، يمكنك ببساطة إلغاء تثبيت التطبيق (Uninstall) من هاتفك، مما يؤدي لمسح قاعدة البيانات المحلية المتبقية.</p>
        </div>

        <p style="font-size: 14px; color: var(--text-muted); margin-top: 24px;">
          البريد المباشر لمسؤول حماية البيانات: <a href="mailto:mohamedhessan139@gmail.com">mohamedhessan139@gmail.com</a><br>
          للعودة لـ <a href="/privacy">سياسة الخصوصية الشاملة</a>.
        </p>
      `,
      contentEn: `
        <span class="badge">Google Play Data Safety Compliance</span>
        <h1 style="color: var(--primary);">Delete Your Kashkool Account & Data</h1>
        <p>In full compliance with Google Play User Data policies and user privacy rights, you have the right to permanently purge your cloud account and all associated backup data from our infrastructure.</p>

        <div class="alert-box" style="border-left-color: var(--primary);">
          <p>⚠️ <strong>Permanent Deletion Notice:</strong> Account deletion is permanent and cannot be undone. All cloud ledger backups, Google authentication sessions, and store memberships will be irrevocably destroyed.</p>
        </div>

        <div style="background: var(--bg); border: 1px solid var(--border); padding: 24px; border-radius: 14px; margin: 24px 0;">
          <h3 style="color: #108e68; margin-top: 0;">Option 1: Instant In-App Deletion (Recommended)</h3>
          <ol>
            <li>Open the <strong>Kashkool</strong> app on your Android device.</li>
            <li>Navigate to <strong>Settings</strong> → <strong>Cloud Backup</strong>.</li>
            <li>Scroll down and tap <strong>"Delete my cloud account"</strong>.</li>
            <li>Confirm the action in the prompt. All server-side data is deleted immediately.</li>
          </ol>
        </div>

        <div style="border: 1px solid var(--primary-border); padding: 24px; border-radius: 14px; margin: 24px 0;">
          <h3 style="color: var(--primary); margin-top: 0;">Option 2: Web Deletion Request (If app is uninstalled)</h3>
          <p>If you no longer have access to the app, you can submit an email deletion request directly to our Data Protection Officer at: <a href="mailto:mohamedhessan139@gmail.com?subject=Delete%20My%20Kashkool%20Account">mohamedhessan139@gmail.com</a> with the subject <em>"Delete My Kashkool Account"</em> from your registered Google address. Your cloud data will be purged within 48 hours.</p>
        </div>

        <p style="font-size: 14px; color: var(--text-muted); margin-top: 20px;">
          Direct DPO Support: <a href="mailto:mohamedhessan139@gmail.com">mohamedhessan139@gmail.com</a><br>
          Read our complete <a href="/privacy">Privacy Policy</a>.
        </p>
      `,
    }),
  );
});

publicPagesRouter.get(['/terms', '/terms-of-service'], (req, res) => {
  res.type('html').send(
    renderLayout({
      title: 'بنود وشروط الخدمة (Terms of Service)',
      contentAr: `
        <span class="badge">وثيقة شروط الاستخدام الرسمية المعتمدة</span>
        <h1>بنود وشروط الخدمة — تطبيق كشكول (Kashkool)</h1>
        <p><strong>تاريخ السريان:</strong> 18 نوفمبر 2026 | <strong>آخر تحديث:</strong> 18 نوفمبر 2026</p>

        <div class="alert-box">
          <strong>مرحباً بك في كشكول!</strong> بتحميلك أو استخدامك لتطبيق كشكول، فإنك توافق على الالتزام الكامل بهذه الشروط والبنود، والامتثال لجميع القوانين المعمول بها. إذا كنت لا توافق على هذه البنود، يُرجى عدم استخدام التطبيق.
        </div>

        <h2>1. طبيعة التطبيق والخدمة (Nature of the Service)</h2>
        <p>تطبيق <strong>كشكول</strong> هو أداة برمجية رقمية ومحاسبية شخصية مخصصة لأصحاب المحلات والأنشطة التجارية الصغيرة والمتوسطة لاستبدال الدفتر الورقي ("الكشكول") لتسجيل ومتابعة حركة المبيعات، والديون التجارية البينية مع الزبائن والموردين، وحركة الخزينة اليومية.</p>
        <div class="alert-box" style="background: #fffbeb; border-color: #f59e0b;">
          ⚠️ <strong>إقرار صريح بعدم تقديم خدمات مصرفية أو قروض:</strong> تطبيق كشكول <strong>ليس بنكاً</strong>، وليس مؤسسة تمويل مصرفي أو استهلاكي، ولا يقدم أي قروض شخصية أو تسهيلات ائتمانية أو خدمات دفع إلكتروني أو خدمات الشراء الآن والدفع لاحقاً (BNPL). التطبيق مجرد أداة دفترية تنظيمية لتسجيل الحسابات بين أطرافها.
        </div>

        <h2>2. الحسابات واستخدام التطبيق (Accounts & Local-First)</h2>
        <ul>
          <li><strong>الاستخدام المجاني والمحلي:</strong> كشكول يعمل بشكل محلي وتلقائي على جهازك (Offline-First) دون اشتراط إنشاء حساب أو إدخال بريد إلكتروني.</li>
          <li><strong>النسخ الاحتياطي السحابي (اختياري):</strong> في حال رغبت في تفعيل النسخ السحابي لحماية بياناتك من الضياع، يتم تسجيل الدخول عبر حساب Google الخاص بك (OAuth).</li>
          <li><strong>أمان الجهاز:</strong> المستخدم مسؤول عن حماية هاتفه وتفعيل وسائل الأمان (مثل قفل التطبيق برمز PIN أو البصمة البيومترية المتوفرة داخل إعدادات التطبيق).</li>
        </ul>

        <h2>3. مسؤولية وصحة البيانات المدخلة</h2>
        <p>يتحمل المستخدم وحده المسؤولية الكاملة عن دقة وصحة الأسماء والأرقام والمعاملات المالية التي يدخلها في التطبيق، والتحقق من حسابات زبائنه ومورديه قبل المطالبة بها أو اعتمادها. لا يتحمل مطور التطبيق أي مسؤولية قانونية عن أي نزاع تجاري أو مالي ينشأ بين التاجر وأي طرف ثالث.</p>

        <h2>4. الملكية الفكرية (Intellectual Property)</h2>
        <p>جميع حقوق الملكية الفكرية، والعلامات التجارية، والتصميمات، والبرمجيات، والأكواد المصدرية الخاصة بتطبيق "كشكول" هي ملك حصري لمطور التطبيق (Mohamed Hassan). يُحظر نسخ، أو تعديل، أو هندسة عكسية، أو إعادة توزيع أي جزء من التطبيق دون إذن كتابي مسبق.</p>

        <h2>5. الاشتراكات والمدفوعات (In-App Subscriptions)</h2>
        <p>تخضع أي خطط مدفوعة أو اشتراكات احترافية اختيارية داخل التطبيق لشروط وسياسات الدفع الرسمية الخاصة بمتجر <strong>Google Play Billing</strong>. يتم تجديد الاشتراكات تلقائياً ما لم يتم إلغاؤها قبل نهاية الفترة الحالية من خلال إعدادات اشتراكات Google Play في هاتفك.</p>

        <h2>6. إنهاء الحساب وحذف البيانات (Termination & Account Deletion)</h2>
        <p>يحق للمستخدم التوقف عن استخدام التطبيق في أي وقت. كما يتيح التطبيق حذف الحساب السحابي وكافة البيانات المرتبطة به فورياً من داخل إعدادات التطبيق، أو عبر صفحة الويب الرسمية: <a href="/account/delete">حذف الحساب والبيانات</a> أو بمراسلة مسؤول حماية البيانات عبر البريد الإلكتروني.</p>

        <h2>7. إخلاء المسؤولية وحدود الضمان (Disclaimer & Limitation of Liability)</h2>
        <p>يتم تقديم التطبيق "كما هو" (AS IS) دون أي ضمانات صريحة أو ضمنية تتجاوز ما يفرضه القانون. يبذل المطور أقصى درجات العناية التقنية لضمان استقرار التطبيق وتشفير البيانات محلياً (SQLCipher)، ولكن المستخدم ينصح دائماً بالاحتفاظ بنسخ احتياطية دورية لبياناته عبر الميزات المتاحة.</p>

        <h2>8. معلومات الاتصال والدعم الفني (Contact Information)</h2>
        <p>لأي استفسارات بخصوص بنود وشروط الخدمة، يمكنك التواصل مباشرة عبر:</p>
        <p>
          📧 البريد الإلكتروني الرسمي: <a href="mailto:mohamedhessan139@gmail.com">mohamedhessan139@gmail.com</a><br>
          🌐 رابط سياسة الخصوصية: <a href="/privacy">سياسة الخصوصية</a>
        </p>
      `,
      contentEn: `
        <span class="badge">Official Terms of Service</span>
        <h1 style="color: var(--primary);">Terms of Service — Kashkool</h1>
        <p><strong>Effective Date:</strong> November 18, 2026 | <strong>Last Updated:</strong> November 18, 2026</p>

        <div class="alert-box">
          <strong>Welcome to Kashkool!</strong> By installing, accessing, or using the Kashkool mobile application, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the application.
        </div>

        <h2>1. Purpose and Scope of Service</h2>
        <p><strong>Kashkool</strong> is a digital bookkeeping and shopkeeper ledger application designed for small and medium retail merchants to replace physical paper notebooks for tracking day-to-day store transactions, customer and supplier credit balances, and cash drawer records.</p>
        <div class="alert-box" style="background: #fffbeb; border-color: #f59e0b;">
          ⚠️ <strong>Non-Lending Declaration:</strong> Kashkool is <strong>NOT</strong> a financial institution, bank, credit broker, or loan provider. It does not provide consumer loans, payday advances, peer-to-peer financing, or Buy Now Pay Later (BNPL) services. The app is purely an offline-first bookkeeping ledger tool.
        </div>

        <h2>2. Accounts and Offline Usage</h2>
        <p>Kashkool functions offline-first on your device without requiring mandatory registration. If you choose to enable cloud backup, authentication is securely handled via your Google Account (OAuth). You are responsible for maintaining the physical security of your device and using available security features such as PIN or biometric authentication.</p>

        <h2>3. User Data and Accuracy</h2>
        <p>You remain solely responsible for the accuracy of all customer records, transactions, amounts, and notes entered into your ledger. Kashkool does not mediate or assume liability for commercial disputes between merchants and their customers.</p>

        <h2>4. Intellectual Property</h2>
        <p>All intellectual property rights, trademarks, application design, software architecture, and source code belong exclusively to Mohamed Hassan. Unauthorized reproduction, reverse engineering, or redistribution is strictly prohibited.</p>

        <h2>5. In-App Subscriptions</h2>
        <p>Any optional premium subscriptions offered are processed securely via <strong>Google Play In-App Billing</strong> in accordance with Google Play Terms of Service and refund policies.</p>

        <h2>6. Account Deletion and Rights</h2>
        <p>Users may request deletion of their cloud backup account and records at any time directly through the app or online at <a href="/account/delete">https://backend-gamma-ten-87.vercel.app/account/delete</a>, or by contacting our Data Protection Officer.</p>

        <h2>7. Contact Us</h2>
        <p>For inquiries regarding these Terms of Service, please contact us at:</p>
        <p>
          📧 Official DPO Email: <a href="mailto:mohamedhessan139@gmail.com">mohamedhessan139@gmail.com</a><br>
          🌐 Privacy Policy: <a href="/privacy">Privacy Policy</a>
        </p>
      `,
    }),
  );
});
