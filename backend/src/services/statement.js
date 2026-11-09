/**
 * Builds the data shown on a customer's public statement page (spec 20).
 * Regular credit ("شكك") and installment plans are shown separately.
 */
export function buildStatement({ customer, transactions, plans, schedules }) {
  const credit = transactions
    .filter((t) => !t.deletedAt && !t.installmentPlanId)
    .sort((a, b) => Date.parse(a.occurredAt || a.createdAt || 0) - Date.parse(b.occurredAt || b.createdAt || 0));

  let running = 0;
  const rows = credit.map((t) => {
    running += t.type === 'debt' ? t.amountPiasters : -t.amountPiasters;
    return {
      date: t.occurredAt || t.createdAt || null,
      note: t.note || null,
      debit: t.type === 'debt' ? t.amountPiasters : 0,
      credit: t.type === 'payment' ? t.amountPiasters : 0,
      balance: running,
    };
  });

  const planSummaries = plans
    .filter((p) => !p.deletedAt && (p.status ?? 'active') === 'active')
    .map((plan) => {
      const paid = transactions
        .filter((t) => !t.deletedAt && t.installmentPlanId === plan.id && t.type === 'payment')
        .reduce((sum, t) => sum + t.amountPiasters, 0);
      const remaining = Math.max(0, plan.totalPricePiasters - paid);

      // FIFO: payments after the down payment cover installments in order.
      let available = Math.max(0, paid - (plan.downPaymentPiasters || 0));
      let nextDue = null;
      const rowsForPlan = (schedules[plan.id] || [])
        .filter((r) => !r.deletedAt)
        .sort((a, b) => (a.installmentIndex ?? a.index ?? 0) - (b.installmentIndex ?? b.index ?? 0));
      for (const r of rowsForPlan) {
        if (available >= r.amountPiasters) {
          available -= r.amountPiasters;
          continue;
        }
        nextDue = { date: r.dueDate || null, amount: r.amountPiasters - available };
        break;
      }
      return {
        item: plan.itemDescription || null,
        planNumber: plan.planNumber || null,
        total: plan.totalPricePiasters,
        paid,
        remaining,
        nextDue,
      };
    });

  return {
    customerFirstName: String(customer.name || '').trim().split(/\s+/)[0] || '',
    balance: running,
    rows: rows.slice(-100),
    totalRows: rows.length,
    plans: planSummaries,
  };
}

export function formatMoney(piasters) {
  const sign = piasters < 0 ? '-' : '';
  const abs = Math.abs(piasters);
  const pounds = Math.floor(abs / 100).toLocaleString('en-US');
  const rest = abs % 100;
  return `${sign}${pounds}${rest ? '.' + String(rest).padStart(2, '0') : ''} جنيه`;
}

const escapeHtml = (s) =>
  String(s ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]);

const fmtDate = (iso) => {
  if (!iso) return '';
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return '';
  return `${d.getUTCFullYear()}/${String(d.getUTCMonth() + 1).padStart(2, '0')}/${String(d.getUTCDate()).padStart(2, '0')}`;
};

const PAGE_STYLE = `
  *{box-sizing:border-box}body{margin:0;font-family:system-ui,-apple-system,"Segoe UI",Tahoma,sans-serif;background:#f3f4f6;color:#111827}
  main{max-width:640px;margin:0 auto;padding:16px}
  .card{background:#fff;border-radius:16px;padding:16px;margin-bottom:12px;box-shadow:0 1px 2px rgba(0,0,0,.06)}
  h1{font-size:20px;margin:0 0 4px}.muted{color:#6b7280;font-size:13px}
  .balance{font-size:30px;font-weight:700;margin:8px 0}.owe{color:#dc2626}.clear{color:#16a34a}
  table{width:100%;border-collapse:collapse;font-size:13px}th,td{padding:8px 4px;border-bottom:1px solid #e5e7eb;text-align:right}
  th{color:#6b7280;font-weight:600}.num{white-space:nowrap}.foot{text-align:center;color:#9ca3af;font-size:12px;margin:24px 0}
  @media (prefers-color-scheme:dark){body{background:#111827;color:#f9fafb}.card{background:#1f2937}th,td{border-color:#374151}}
`;

export function renderStatementPage({ shop, statement, generatedAt = new Date() }) {
  const s = statement;
  const balanceClass = s.balance > 0 ? 'owe' : 'clear';
  const rows = s.rows
    .map(
      (r) => `<tr><td class="num">${fmtDate(r.date)}</td><td>${escapeHtml(r.note || '')}</td>
      <td class="num">${r.debit ? formatMoney(r.debit) : ''}</td><td class="num">${r.credit ? formatMoney(r.credit) : ''}</td>
      <td class="num">${formatMoney(r.balance)}</td></tr>`,
    )
    .join('');
  const plans = s.plans
    .map(
      (p) => `<div class="card"><strong>${escapeHtml(p.item || 'تقسيط')}</strong>${p.planNumber ? ` <span class="muted">#${escapeHtml(p.planNumber)}</span>` : ''}
      <div class="muted">الإجمالي ${formatMoney(p.total)} · المدفوع ${formatMoney(p.paid)}</div>
      <div><strong>المتبقي: ${formatMoney(p.remaining)}</strong></div>
      ${p.nextDue ? `<div class="muted">القسط الجاي: ${formatMoney(p.nextDue.amount)} يوم ${fmtDate(p.nextDue.date)}</div>` : ''}</div>`,
    )
    .join('');

  return `<!doctype html><html lang="ar" dir="rtl"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1"><meta name="robots" content="noindex,nofollow">
<title>كشف حساب - ${escapeHtml(shop.name)}</title><style>${PAGE_STYLE}</style></head><body><main>
<div class="card"><h1>${escapeHtml(shop.name)}</h1>
<div class="muted">كشف حساب أ/ ${escapeHtml(s.customerFirstName)}</div>
<div class="balance ${balanceClass}">${s.balance > 0 ? formatMoney(s.balance) : 'خالصين ✓'}</div>
${shop.paymentInfo ? `<div class="muted">للدفع: ${escapeHtml(shop.paymentInfo)}</div>` : ''}
${shop.phone ? `<div class="muted">تليفون المحل: <span dir="ltr">${escapeHtml(shop.phone)}</span></div>` : ''}
</div>
${plans}
<div class="card"><table><thead><tr><th>التاريخ</th><th>البيان</th><th>عليه</th><th>دفع</th><th>الرصيد</th></tr></thead>
<tbody>${rows || '<tr><td colspan="5" class="muted">مفيش عمليات</td></tr>'}</tbody></table>
${s.totalRows > s.rows.length ? `<div class="muted">بيظهر آخر ${s.rows.length} عملية من ${s.totalRows}</div>` : ''}</div>
<div class="foot">آخر تحديث ${fmtDate(generatedAt.toISOString())} · اتعمل بكشكول 📒</div>
</main></body></html>`;
}

export function renderMessagePage(title, message) {
  return `<!doctype html><html lang="ar" dir="rtl"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1"><meta name="robots" content="noindex,nofollow">
<title>${escapeHtml(title)}</title><style>${PAGE_STYLE}</style></head><body><main>
<div class="card"><h1>${escapeHtml(title)}</h1><p class="muted">${escapeHtml(message)}</p></div>
<div class="foot">كشكول 📒</div></main></body></html>`;
}
