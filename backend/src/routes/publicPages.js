import { Router } from 'express';
import { config } from '../config.js';

/**
 * Public pages Google Play asks for:
 *  - /privacy          → Privacy policy URL (Play Console → App content → Privacy policy)
 *  - /account/delete   → Account deletion URL (Play Console → App content → Data safety)
 * Plain HTML, English + Arabic, no scripts.
 */
export const publicPagesRouter = Router();

const esc = (s) => String(s).replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]);

function page(title, enBody, arBody) {
  const email = config.supportEmail;
  const contactEn = email ? `<p>Contact: <a href="mailto:${esc(email)}">${esc(email)}</a></p>` : '';
  const contactAr = email ? `<p>للتواصل: <a href="mailto:${esc(email)}">${esc(email)}</a></p>` : '';
  return `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${esc(title)} — Kashkool</title>
<style>
  :root { color-scheme: light dark; --fg:#111827; --muted:#6b7280; --bg:#f8fafc; --card:#fff; --line:#e5e7eb; }
  @media (prefers-color-scheme: dark) { :root { --fg:#f3f4f6; --muted:#9ca3af; --bg:#0b1120; --card:#111827; --line:#273244; } }
  body { margin:0; font-family: system-ui, -apple-system, "Segoe UI", Tahoma, sans-serif; background:var(--bg); color:var(--fg); line-height:1.65; }
  main { max-width: 760px; margin: 0 auto; padding: 24px 16px 48px; }
  section { background:var(--card); border:1px solid var(--line); border-radius:14px; padding:20px; margin-top:16px; }
  h1 { font-size: 24px; margin: 8px 0 0; } h2 { font-size: 18px; margin-top: 20px; }
  p, li { color: var(--fg); } small { color: var(--muted); }
  [dir="rtl"] { text-align: right; }
</style>
</head>
<body>
<main>
  <h1>${esc(title)}</h1>
  <small>Kashkool · Last updated: ${new Date().toISOString().slice(0, 10)}</small>
  <section>${enBody}${contactEn}</section>
  <section dir="rtl" lang="ar">${arBody}${contactAr}</section>
</main>
</body>
</html>`;
}

publicPagesRouter.get('/privacy', (req, res) => {
  res.set('Cache-Control', 'public, max-age=3600');
  res.type('html').send(
    page(
      'Privacy Policy',
      `<h2>What Kashkool stores</h2>
<p>Kashkool is a ledger for shop owners. Everything you enter — customers, suppliers, names, phone numbers, amounts, notes and photos — is stored on your phone in an encrypted database. Photos never leave your phone.</p>
<h2>Cloud backup (optional)</h2>
<p>If you sign in with Google to use cloud backup, we receive your Google account email and name, and we store a copy of your ledger records (not photos) on our servers so you can restore them on another phone. This data is used only to provide the backup. We do not sell it, share it with advertisers, or use it for ads. Kashkool has no ads.</p>
<h2>Messages to your customers</h2>
<p>Reminder messages are sent from your own WhatsApp or SMS app. Kashkool does not send them through its servers.</p>
<h2>Security</h2>
<p>Data is sent over HTTPS. Access to the backup requires your Google sign-in.</p>
<h2>Deleting your data</h2>
<p>Uninstalling the app removes the data on your phone. To delete your cloud account and backups, open Settings → Cloud backup → “Delete my cloud account” in the app, or see <a href="/account/delete">this page</a>.</p>
<h2>Children</h2>
<p>Kashkool is a business tool and is not directed to children.</p>`,
      `<h2>ما الذي يحفظه كشكول</h2>
<p>كشكول دفتر حسابات لأصحاب المحلات. كل ما تُدخله — العملاء والموردون والأسماء وأرقام الهواتف والمبالغ والملاحظات والصور — يُحفظ على هاتفك في قاعدة بيانات مشفّرة. الصور لا تغادر هاتفك أبدًا.</p>
<h2>النسخ على السحابة (اختياري)</h2>
<p>إذا سجّلت الدخول بحساب جوجل لاستخدام النسخ الاحتياطي، نستلم بريدك واسمك في جوجل، ونحفظ نسخة من سجلات دفترك (بدون الصور) على خوادمنا حتى تستطيع استرجاعها على هاتف آخر. نستخدم هذه البيانات لتقديم النسخ الاحتياطي فقط، ولا نبيعها ولا نشاركها مع معلنين. كشكول بلا إعلانات.</p>
<h2>الرسائل إلى عملائك</h2>
<p>تُرسل رسائل التذكير من تطبيق واتساب أو الرسائل على هاتفك، وليس من خوادم كشكول.</p>
<h2>حذف بياناتك</h2>
<p>حذف التطبيق يمسح البيانات من هاتفك. لحذف حسابك ونسخك على السحابة: الإعدادات ← النسخ على السحابة ← «احذف حسابي على السحابة»، أو راجع <a href="/account/delete">هذه الصفحة</a>.</p>`,
    ),
  );
});

publicPagesRouter.get('/account/delete', (req, res) => {
  res.set('Cache-Control', 'public, max-age=3600');
  res.type('html').send(
    page(
      'Delete your Kashkool account',
      `<p>You can delete your Kashkool cloud account and all its backups at any time:</p>
<ol>
  <li>Open Kashkool.</li>
  <li>Go to <b>Settings → Cloud backup</b>.</li>
  <li>Tap <b>Delete my cloud account</b> and confirm.</li>
</ol>
<h2>What is deleted</h2>
<p>Your account (Google email and name), your sign-in sessions, and the cloud backups of every shop you own are deleted permanently right away. Nothing is kept.</p>
<h2>What is not deleted</h2>
<p>The data on your phone stays until you uninstall the app or delete it there.</p>
<p>If you no longer have the app, email us from the Google account you used and we will delete it for you within 30 days.</p>`,
      `<p>يمكنك حذف حسابك على سحابة كشكول وكل نسخه الاحتياطية في أي وقت:</p>
<ol>
  <li>افتح كشكول.</li>
  <li>ادخل إلى <b>الإعدادات ← النسخ على السحابة</b>.</li>
  <li>اضغط <b>احذف حسابي على السحابة</b> وأكّد.</li>
</ol>
<h2>ما الذي يُحذف</h2>
<p>حسابك (البريد والاسم في جوجل)، وجلسات الدخول، ونسخ السحابة لكل المحلات التي تملكها — تُحذف نهائيًا فورًا.</p>
<h2>ما الذي لا يُحذف</h2>
<p>البيانات على هاتفك تبقى حتى تحذف التطبيق أو تمسحها منه.</p>
<p>إذا لم يعد التطبيق لديك، راسلنا من حساب جوجل الذي استخدمته وسنحذف حسابك خلال 30 يومًا.</p>`,
    ),
  );
});
