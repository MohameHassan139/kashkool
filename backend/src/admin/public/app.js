/* Kashkool admin dashboard — vanilla JS, no build step. */
(() => {
  'use strict';

  const $ = (sel) => document.querySelector(sel);
  const main = $('#main');

  // ---------- helpers ----------

  const esc = (v) =>
    String(v ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]);
  const fmtNum = (n) => (n == null ? '—' : Number(n).toLocaleString('en-US'));
  const fmtDate = (d) => {
    if (!d) return '—';
    const x = new Date(d);
    return Number.isNaN(x.getTime()) ? '—' : x.toLocaleDateString('en-GB', { year: 'numeric', month: '2-digit', day: '2-digit' });
  };
  const fmtDateTime = (d) => {
    if (!d) return '—';
    const x = new Date(d);
    return Number.isNaN(x.getTime()) ? '—' : `${fmtDate(x)} ${x.toLocaleTimeString('en-GB', { hour: '2-digit', minute: '2-digit' })}`;
  };
  const ago = (d) => {
    if (!d) return 'أبداً';
    const mins = Math.round((Date.now() - new Date(d).getTime()) / 60000);
    if (mins < 1) return 'دلوقتي';
    if (mins < 60) return `من ${mins} دقيقة`;
    const hours = Math.round(mins / 60);
    if (hours < 24) return `من ${hours} ساعة`;
    return `من ${Math.round(hours / 24)} يوم`;
  };
  const TIER = { free: 'مجاني', pro: 'Pro', installments_pro: 'أقساط Pro' };
  const SOURCE = { free: '', play: 'اشتراك', trial: 'تجربة', referral_bonus: 'مكافأة ترشيح' };
  const TYPE = {
    grocery: 'بقالة', mobile: 'موبايلات', electronics: 'أجهزة', furniture: 'أثاث',
    pharmacy: 'صيدلية', spare_parts: 'قطع غيار', other: 'أخرى',
  };
  const COLLECTION = {
    customers: 'عملاء', suppliers: 'موردين', transactions: 'عمليات', installment_plans: 'خطط أقساط',
    installments: 'أقساط', installment_events: 'أحداث أقساط', installment_attachments: 'مرفقات',
    cash_days: 'أيام الدرج', expenses: 'مصاريف', settings: 'إعدادات',
  };
  const tierPill = (tier, source) =>
    `<span class="tier"><span class="pill ${esc(tier)}">${esc(TIER[tier] || tier)}</span>${source && SOURCE[source] ? ` <span class="muted small">${esc(SOURCE[source])}</span>` : ''}</span>`;

  let toastTimer;
  function toast(msg) {
    const el = $('#toast');
    el.textContent = msg;
    el.hidden = false;
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => (el.hidden = true), 3500);
  }

  class ApiError extends Error {
    constructor(status, body) {
      super(body?.message || `HTTP ${status}`);
      this.status = status;
      this.code = body?.error;
    }
  }

  async function api(path, { method = 'GET', body } = {}) {
    const res = await fetch(`/admin/api${path}`, {
      method,
      credentials: 'same-origin',
      headers: { 'Content-Type': 'application/json', 'X-Kashkool-Admin': '1' },
      body: body ? JSON.stringify(body) : undefined,
    });
    const data = res.status === 204 ? null : await res.json().catch(() => null);
    if (res.status === 401) {
      showLogin();
      throw new ApiError(401, data);
    }
    if (!res.ok) throw new ApiError(res.status, data);
    return data;
  }

  /** Vertical bar chart as inline SVG. series: [{day, count}] (one or two series). */
  function barChart(seriesA, seriesB) {
    const w = 600, h = 160, pad = 22;
    const n = seriesA.length;
    const max = Math.max(1, ...seriesA.map((p) => p.count), ...(seriesB || []).map((p) => p.count));
    const slot = (w - pad) / n;
    const barW = seriesB ? slot * 0.38 : slot * 0.7;
    const y = (v) => h - pad - ((h - pad * 1.6) * v) / max;
    let bars = '';
    seriesA.forEach((p, i) => {
      const x = pad + i * slot + (seriesB ? slot * 0.1 : slot * 0.15);
      bars += `<rect class="bar" x="${x.toFixed(1)}" y="${y(p.count).toFixed(1)}" width="${barW.toFixed(1)}" height="${(h - pad - y(p.count)).toFixed(1)}" rx="2"><title>${esc(p.day)}: ${p.count}</title></rect>`;
      if (seriesB) {
        const q = seriesB[i];
        bars += `<rect class="bar alt" x="${(x + barW + 1).toFixed(1)}" y="${y(q.count).toFixed(1)}" width="${barW.toFixed(1)}" height="${(h - pad - y(q.count)).toFixed(1)}" rx="2"><title>${esc(q.day)}: ${q.count}</title></rect>`;
      }
    });
    const ticks = [0, Math.floor(n / 2), n - 1]
      .map((i) => `<text class="tick" x="${(pad + i * slot + slot / 2).toFixed(1)}" y="${h - 6}" text-anchor="middle">${esc(seriesA[i].day.slice(5))}</text>`)
      .join('');
    return `<svg viewBox="0 0 ${w} ${h}" role="img" preserveAspectRatio="none" direction="ltr">
      <line class="axis" x1="${pad}" y1="${h - pad}" x2="${w}" y2="${h - pad}"/>
      <text class="tick" x="2" y="${y(max) + 4}">${max}</text>
      ${bars}${ticks}</svg>`;
  }

  function barList(entries, labels) {
    const total = Math.max(1, ...entries.map(([, v]) => v));
    if (!entries.length) return '<div class="empty">مفيش بيانات</div>';
    return `<div class="bar-list">${entries
      .map(
        ([k, v]) => `<div class="bar-row"><span>${esc(labels[k] || k)}</span>
        <div class="bar-track"><div class="bar-fill" style="width:${((v / total) * 100).toFixed(1)}%"></div></div>
        <span class="num">${fmtNum(v)}</span></div>`,
      )
      .join('')}</div>`;
  }

  const kpi = (label, value, hint) =>
    `<div class="card kpi"><div class="label">${esc(label)}</div><div class="value num">${value}</div>${hint ? `<div class="hint">${hint}</div>` : ''}</div>`;

  // ---------- pages ----------

  const pages = {
    async overview() {
      const o = await api('/overview');
      const r = o.revenue;
      main.innerHTML = `
        <div class="page-head"><h1>نظرة عامة</h1><span class="muted small">آخر تحديث ${esc(fmtDateTime(o.generatedAt))}</span></div>
        <div class="grid kpis">
          ${kpi('المحلات', fmtNum(o.shops.total), `+${fmtNum(o.shops.new7d)} آخر 7 أيام`)}
          ${kpi('نشطة النهارده', fmtNum(o.shops.active1d), `${fmtNum(o.shops.active7d)} في 7 أيام · ${fmtNum(o.shops.active30d)} في 30 يوم`)}
          ${kpi('محلات بتدفع', fmtNum(r.payingShops), `${fmtNum(r.sources.trial)} في التجربة · ${fmtNum(r.sources.referral_bonus)} مكافأة`)}
          ${kpi('الإيراد الشهري التقديري', `${fmtNum(r.estimatedMrrEgp)} <span class="small muted">ج.م</span>`, 'من اشتراكات Google Play النشطة')}
          ${kpi('التحويل من التجربة', r.trialConversionRate == null ? '—' : `${r.trialConversionRate}%`, `${fmtNum(r.trialConverted)} من ${fmtNum(r.trialStarted)}`)}
          ${kpi('المستخدمين', fmtNum(o.users.total), `${fmtNum(o.users.active7d)} دخلوا آخر 7 أيام · ${fmtNum(o.users.employees)} عامل`)}
        </div>
        <div class="grid two">
          <div class="card chart"><h2>محلات جديدة ومحلات نشطة — آخر 30 يوم</h2>
            ${barChart(o.charts.newShops, o.charts.activeShops)}
            <div class="legend"><span><i style="background:var(--chart)"></i>جديدة</span><span><i style="background:var(--chart-2)"></i>عملت مزامنة</span></div>
          </div>
          <div class="card chart"><h2>مستخدمين جدد — آخر 30 يوم</h2>${barChart(o.charts.newUsers)}</div>
          <div class="card"><h2>الباقات</h2>${barList(Object.entries(r.tiers), TIER)}</div>
          <div class="card"><h2>أنواع المحلات</h2>${barList(Object.entries(o.shops.byType).sort((a, b) => b[1] - a[1]), TYPE)}</div>
          <div class="card"><h2>الترشيحات</h2>${barList(
            [['pending', o.referrals.pending], ['rewarded', o.referrals.rewarded], ['qualified', o.referrals.qualified]],
            { pending: 'مستنية', rewarded: 'اتكافأت', qualified: 'مؤهلة بدون مكافأة' },
          )}</div>
        </div>`;
    },

    async shops(params) {
      const q = params.get('q') || '';
      const sort = params.get('sort') || 'newest';
      const page = Number(params.get('page') || 1);
      main.innerHTML = `
        <div class="page-head"><h1>المحلات</h1>
          <form class="toolbar" id="shop-search">
            <input type="search" name="q" value="${esc(q)}" placeholder="اسم المحل، إيميل المالك، أو كود الترشيح" aria-label="بحث">
            <select name="sort" aria-label="ترتيب">
              <option value="newest">الأحدث</option><option value="lastSync">آخر مزامنة</option><option value="name">الاسم</option>
            </select>
            <button class="btn" type="submit">بحث</button>
          </form>
        </div>
        <div class="card"><div id="shops-table" class="loading">بيحمّل…</div></div>`;
      $('#shop-search select').value = sort;
      $('#shop-search').addEventListener('submit', (e) => {
        e.preventDefault();
        const f = new FormData(e.target);
        location.hash = `shops?${new URLSearchParams({ q: f.get('q'), sort: f.get('sort') })}`;
      });

      const data = await api(`/shops?${new URLSearchParams({ q, sort, page })}`);
      const rows = data.shops
        .map(
          (s) => `<tr class="clickable" data-id="${esc(s.id)}" tabindex="0">
            <td><strong>${esc(s.name)}</strong><div class="muted small">${esc(TYPE[s.type] || s.type || '')}</div></td>
            <td>${esc(s.ownerEmail || '—')}</td>
            <td>${tierPill(s.tier, s.tierSource)}</td>
            <td>${esc(ago(s.lastSyncAt))}</td>
            <td class="num">${fmtNum(s.members)}</td>
            <td class="num">${fmtNum(s.devices)}</td>
            <td>${esc(fmtDate(s.createdAt))}</td></tr>`,
        )
        .join('');
      const totalPages = Math.max(1, Math.ceil(data.total / data.pageSize));
      $('#shops-table').className = '';
      $('#shops-table').innerHTML = `
        <div class="table-wrap"><table>
          <thead><tr><th>المحل</th><th>المالك</th><th>الباقة</th><th>آخر مزامنة</th><th>أعضاء</th><th>أجهزة</th><th>اتسجل</th></tr></thead>
          <tbody>${rows || '<tr><td colspan="7" class="empty">مفيش محلات</td></tr>'}</tbody>
        </table></div>
        <div class="pager">
          <button class="btn ghost small" data-page="${page - 1}" ${page <= 1 ? 'disabled' : ''}>السابق</button>
          <span class="muted small">صفحة ${page} من ${totalPages} · ${fmtNum(data.total)} محل</span>
          <button class="btn ghost small" data-page="${page + 1}" ${page >= totalPages ? 'disabled' : ''}>التالي</button>
        </div>`;
      const open = (id) => (location.hash = `shop/${encodeURIComponent(id)}`);
      main.querySelectorAll('tr[data-id]').forEach((tr) => {
        tr.addEventListener('click', () => open(tr.dataset.id));
        tr.addEventListener('keydown', (e) => e.key === 'Enter' && open(tr.dataset.id));
      });
      main.querySelectorAll('[data-page]').forEach((b) =>
        b.addEventListener('click', () => (location.hash = `shops?${new URLSearchParams({ q, sort, page: b.dataset.page })}`)),
      );
    },

    async shop(params, id) {
      const d = await api(`/shops/${encodeURIComponent(id)}`);
      const s = d.shop;
      const counts = Object.entries(d.recordCounts).filter(([, v]) => v > 0);
      main.innerHTML = `
        <a href="#shops" class="back">→ رجوع للمحلات</a>
        <div class="page-head"><h1>${esc(s.name)}</h1>${tierPill(s.tier, s.tierSource)}</div>
        <div class="grid two" style="margin-top:0">
          <div class="card"><h2>بيانات المحل</h2><dl class="meta">
            <dt>النوع</dt><dd>${esc(TYPE[s.type] || s.type)}</dd>
            <dt>المالك</dt><dd>${esc(s.ownerEmail || '—')}</dd>
            <dt>تليفون</dt><dd class="num">${esc(s.phone || '—')}</dd>
            <dt>كود الترشيح</dt><dd class="num">${esc(s.shopCode || '—')}</dd>
            <dt>اتسجل</dt><dd>${esc(fmtDateTime(s.createdAt))}</dd>
            <dt>آخر مزامنة</dt><dd>${esc(fmtDateTime(s.lastSyncAt))} <span class="muted small">(${esc(ago(s.lastSyncAt))})</span></dd>
            <dt>الباقة تنتهي</dt><dd>${esc(fmtDate(s.tierExpiresAt))}</dd>
            <dt>التجربة لحد</dt><dd>${esc(fmtDate(s.trialEndsAt))}</dd>
            <dt>مكافأة لحد</dt><dd>${esc(fmtDate(s.bonusProUntil))}</dd>
            <dt>ID</dt><dd class="num small">${esc(s.id)}</dd>
          </dl></div>
          <div class="card"><h2>هدية أيام Pro</h2>
            <p class="muted small">للدعم أو التعويض. بتتضاف على أي مكافأة موجودة، وبتتسجل في سجل العمليات.</p>
            <form id="grant" class="form-grid">
              <label class="field">عدد الأيام<input name="days" type="number" min="1" max="365" value="30" required></label>
              <label class="field">السبب<input name="reason" minlength="3" maxlength="200" placeholder="مثلاً: تعويض عن مشكلة مزامنة" required></label>
              <div><button class="btn" type="submit">ضيف الأيام</button></div>
            </form>
          </div>
          <div class="card"><h2>عدد السجلات على السحابة</h2>
            ${counts.length ? barList(counts, COLLECTION) : '<div class="empty">لسه معملش مزامنة</div>'}
            <p class="muted small">أعداد بس — بيانات العملاء والمبالغ مش بتظهر هنا.</p>
          </div>
          <div class="card"><h2>الأعضاء</h2><div class="table-wrap"><table>
            <thead><tr><th>الإيميل</th><th>الدور</th><th>الحالة</th></tr></thead>
            <tbody>${d.members
              .map(
                (m) => `<tr><td>${esc(m.email || '—')}</td><td>${m.role === 'owner' ? 'المالك' : 'عامل'}</td>
                <td>${m.active ? '<span class="pill ok">نشط</span>' : '<span class="pill bad">موقوف</span>'}</td></tr>`,
              )
              .join('')}</tbody></table></div>
            <h2 style="margin-top:16px">الأجهزة</h2>
            ${d.devices.length ? d.devices.map((x) => `<div class="small">${esc(x.prefix)} — ${esc(x.label || 'جهاز')} · ${esc(fmtDate(x.firstSeenAt))}</div>`).join('') : '<div class="muted small">مفيش</div>'}
          </div>
          <div class="card"><h2>الاشتراكات</h2>${
            d.subscriptions.length
              ? `<div class="table-wrap"><table><thead><tr><th>الباقة</th><th>الحالة</th><th>ينتهي</th></tr></thead><tbody>${d.subscriptions
                  .map((x) => `<tr><td>${tierPill(x.tier)}</td><td class="small">${esc(stateLabel(x.state))}</td><td>${esc(fmtDate(x.expiresAt))}</td></tr>`)
                  .join('')}</tbody></table></div>`
              : '<div class="empty">مفيش اشتراكات</div>'
          }
            <h2 style="margin-top:16px">الترشيحات</h2>
            <div class="small">اترشح من محل تاني: ${d.referredBy ? esc(refLabel(d.referredBy.status)) : 'لأ'}</div>
            <div class="small">رشّح ${fmtNum(d.referralsMade.length)} محل، اتكافأ عن ${fmtNum(d.referralsMade.filter((r) => r.status === 'rewarded').length)}</div>
          </div>
          <div class="card"><h2>أيام النشاط (آخر 30 مزامنة)</h2>
            <div class="small num">${d.activeDays.length ? d.activeDays.map(esc).join(' · ') : '<span class="muted">مفيش</span>'}</div>
          </div>
        </div>`;
      $('#grant').addEventListener('submit', async (e) => {
        e.preventDefault();
        const f = new FormData(e.target);
        const days = Number(f.get('days'));
        if (!confirm(`تضيف ${days} يوم Pro لمحل "${s.name}"؟`)) return;
        try {
          const r = await api(`/shops/${encodeURIComponent(id)}/grant`, { method: 'POST', body: { days, reason: f.get('reason') } });
          toast(`اتضافت. المكافأة لحد ${fmtDate(r.bonusProUntil)}`);
          route();
        } catch (err) {
          toast(err.message);
        }
      });
    },

    async subscriptions() {
      const d = await api('/subscriptions');
      main.innerHTML = `
        <div class="page-head"><h1>الاشتراكات</h1><span class="muted small">${fmtNum(d.subscriptions.length)} اشتراك</span></div>
        <div class="card"><div class="table-wrap"><table>
          <thead><tr><th>المحل</th><th>الباقة</th><th>الحالة</th><th>المنتج</th><th>ينتهي</th><th>آخر إشعار</th><th>اتحدث</th></tr></thead>
          <tbody>${
            d.subscriptions
              .map(
                (x) => `<tr class="clickable" data-id="${esc(x.shopId)}" tabindex="0"><td>${esc(x.shopName || x.shopId)}</td><td>${tierPill(x.tier)}</td>
                <td>${statePill(x.state)}</td><td class="small num">${esc(x.productId || '')}</td><td>${esc(fmtDate(x.expiresAt))}</td>
                <td class="small">${esc(x.lastNotificationType ?? '—')}</td><td>${esc(fmtDateTime(x.updatedAt))}</td></tr>`,
              )
              .join('') || '<tr><td colspan="7" class="empty">مفيش اشتراكات لسه</td></tr>'
          }</tbody></table></div></div>`;
      linkRows();
    },

    async referrals() {
      const d = await api('/referrals');
      main.innerHTML = `
        <div class="page-head"><h1>الترشيحات</h1><span class="muted small">${fmtNum(d.referrals.length)} ترشيح</span></div>
        <div class="card"><div class="table-wrap"><table>
          <thead><tr><th>المرشِّح</th><th>المحل الجديد</th><th>الحالة</th><th>اتعمل</th><th>اتكافأ</th></tr></thead>
          <tbody>${
            d.referrals
              .map(
                (r) => `<tr><td><a href="#shop/${encodeURIComponent(r.referrerShopId)}">${esc(r.referrerName || r.referrerShopId)}</a></td>
                <td><a href="#shop/${encodeURIComponent(r.referredShopId)}">${esc(r.referredName || r.referredShopId)}</a></td>
                <td>${refPill(r.status)}</td><td>${esc(fmtDate(r.createdAt))}</td><td>${esc(fmtDate(r.rewardedAt))}</td></tr>`,
              )
              .join('') || '<tr><td colspan="5" class="empty">مفيش ترشيحات لسه</td></tr>'
          }</tbody></table></div></div>`;
    },

    async config() {
      const c = await api('/config');
      main.innerHTML = `
        <div class="page-head"><h1>إعدادات التطبيق عن بُعد</h1></div>
        <form id="cfg" class="card">
          <p class="muted small">التطبيق بيقرا الإعدادات دي من <span class="num">/v1/config</span>. التغيير بيوصل للموبايلات خلال دقايق.</p>
          <div class="form-grid">
            <label class="field">أقل نسخة مسموح بيها (إجبار تحديث)<input name="minSupportedVersion" value="${esc(c.minSupportedVersion)}" pattern="\\d+\\.\\d+\\.\\d+" required dir="ltr"></label>
            <label class="field">آخر نسخة<input name="latestVersion" value="${esc(c.latestVersion)}" pattern="\\d+\\.\\d+\\.\\d+" required dir="ltr"></label>
          </div>
          <label class="field" style="margin-top:12px">إعلان يظهر للتجار (سيبه فاضي عشان تشيله)
            <input name="announcementText" value="${esc(c.announcement?.text || '')}" maxlength="300"></label>
          <label class="field" style="margin-top:12px">نوع الإعلان
            <select name="announcementLevel"><option value="info">معلومة</option><option value="warning">تحذير</option></select></label>
          <label class="field" style="margin-top:12px">Feature flags (JSON)
            <textarea name="flags" spellcheck="false">${esc(JSON.stringify(c.flags || {}, null, 2))}</textarea></label>
          <div style="margin-top:12px"><button class="btn" type="submit">حفظ</button></div>
        </form>`;
      $('#cfg [name=announcementLevel]').value = c.announcement?.level || 'info';
      $('#cfg').addEventListener('submit', async (e) => {
        e.preventDefault();
        const f = new FormData(e.target);
        let flags;
        try {
          flags = JSON.parse(f.get('flags') || '{}');
        } catch {
          toast('الـ JSON بتاع الـ flags فيه غلط');
          return;
        }
        const text = String(f.get('announcementText') || '').trim();
        try {
          await api('/config', {
            method: 'PUT',
            body: {
              minSupportedVersion: f.get('minSupportedVersion'),
              latestVersion: f.get('latestVersion'),
              flags,
              announcement: text ? { text, level: f.get('announcementLevel') } : null,
            },
          });
          toast('اتحفظ ✓');
        } catch (err) {
          toast(err.message);
        }
      });
    },

    async audit() {
      const d = await api('/audit');
      const ACTION = { login: 'تسجيل دخول', grant_pro_days: 'هدية أيام Pro', update_config: 'تعديل الإعدادات' };
      main.innerHTML = `
        <div class="page-head"><h1>سجل العمليات</h1><span class="muted small">آخر 200 عملية</span></div>
        <div class="card"><div class="table-wrap"><table>
          <thead><tr><th>الوقت</th><th>المسؤول</th><th>العملية</th><th>على</th><th>تفاصيل</th></tr></thead>
          <tbody>${
            d.entries
              .map(
                (x) => `<tr><td>${esc(fmtDateTime(x.createdAt))}</td><td>${esc(x.adminEmail)}</td><td>${esc(ACTION[x.action] || x.action)}</td>
                <td class="small num">${esc(x.target || '')}</td><td class="small">${esc(x.details?.reason || (x.details?.days ? `${x.details.days} يوم` : ''))}</td></tr>`,
              )
              .join('') || '<tr><td colspan="5" class="empty">مفيش عمليات</td></tr>'
          }</tbody></table></div></div>`;
    },
  };

  function linkRows() {
    main.querySelectorAll('tr[data-id]').forEach((tr) => {
      const go = () => (location.hash = `shop/${encodeURIComponent(tr.dataset.id)}`);
      tr.addEventListener('click', go);
      tr.addEventListener('keydown', (e) => e.key === 'Enter' && go());
    });
  }

  function stateLabel(state) {
    return (
      {
        SUBSCRIPTION_STATE_ACTIVE: 'نشط',
        SUBSCRIPTION_STATE_IN_GRACE_PERIOD: 'فترة سماح',
        SUBSCRIPTION_STATE_CANCELED: 'ملغي (لحد ما ينتهي)',
        SUBSCRIPTION_STATE_ON_HOLD: 'موقوف (مشكلة دفع)',
        SUBSCRIPTION_STATE_PAUSED: 'متوقف مؤقتاً',
        SUBSCRIPTION_STATE_EXPIRED: 'منتهي',
      }[state] || state || '—'
    );
  }
  function statePill(state) {
    const cls = { SUBSCRIPTION_STATE_ACTIVE: 'ok', SUBSCRIPTION_STATE_IN_GRACE_PERIOD: 'warn', SUBSCRIPTION_STATE_CANCELED: 'warn' }[state] || 'bad';
    return `<span class="pill ${cls}">${esc(stateLabel(state))}</span>`;
  }
  const refLabel = (s) => ({ pending: 'مستني', rewarded: 'اتكافأ', qualified: 'مؤهل بدون مكافأة' })[s] || s;
  const refPill = (s) => `<span class="pill ${s === 'rewarded' ? 'ok' : s === 'pending' ? 'warn' : 'free'}">${esc(refLabel(s))}</span>`;

  // ---------- routing ----------

  async function route() {
    const raw = location.hash.replace(/^#/, '') || 'overview';
    const [pathPart, query = ''] = raw.split('?');
    const [name, arg] = pathPart.split('/');
    const page = pages[name] ? name : 'overview';
    document.querySelectorAll('#nav a').forEach((a) =>
      a.classList.toggle('active', a.dataset.route === (page === 'shop' ? 'shops' : page)),
    );
    main.innerHTML = '<div class="loading">بيحمّل…</div>';
    try {
      await pages[page](new URLSearchParams(query), arg ? decodeURIComponent(arg) : undefined);
    } catch (err) {
      if (err.status === 401) return;
      main.innerHTML = `<div class="card"><p class="error">${esc(err.message)}</p></div>`;
    }
    main.focus({ preventScroll: true });
  }

  // ---------- auth ----------

  function showLogin(message) {
    $('#app').hidden = true;
    $('#login').hidden = false;
    $('#login-error').textContent = message || '';
  }

  async function showApp(email) {
    $('#login').hidden = true;
    $('#app').hidden = false;
    $('#admin-email').textContent = email;
    await route();
  }

  async function onGoogleCredential(response) {
    try {
      const res = await fetch('/admin/api/login', {
        method: 'POST',
        credentials: 'same-origin',
        headers: { 'Content-Type': 'application/json', 'X-Kashkool-Admin': '1' },
        body: JSON.stringify({ credential: response.credential }),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) {
        showLogin(data.error === 'not_admin' ? 'الحساب ده مش مسموح له يدخل لوحة التحكم.' : data.message || 'مقدرناش نسجّل دخول.');
        return;
      }
      await showApp(data.email);
    } catch {
      showLogin('مفيش اتصال بالسيرفر.');
    }
  }

  function renderGoogleButton(clientId) {
    if (!clientId) {
      $('#login-error').textContent = 'GOOGLE_CLIENT_IDS مش متظبط على السيرفر.';
      return;
    }
    const tryRender = (attempt = 0) => {
      if (!window.google?.accounts?.id) {
        if (attempt < 50) setTimeout(() => tryRender(attempt + 1), 100);
        else $('#login-error').textContent = 'مقدرناش نحمّل زرار جوجل. اتأكد من النت.';
        return;
      }
      google.accounts.id.initialize({ client_id: clientId, callback: onGoogleCredential, ux_mode: 'popup' });
      google.accounts.id.renderButton($('#google-button'), { theme: 'outline', size: 'large', text: 'signin_with', locale: 'ar', shape: 'pill' });
    };
    tryRender();
  }

  async function boot() {
    window.addEventListener('hashchange', route);
    $('#logout').addEventListener('click', async () => {
      await fetch('/admin/api/logout', { method: 'POST', credentials: 'same-origin', headers: { 'X-Kashkool-Admin': '1' } });
      if (window.google?.accounts?.id) google.accounts.id.disableAutoSelect();
      location.hash = '';
      showLogin();
    });
    $('#dev-login').addEventListener('submit', async (e) => {
      e.preventDefault();
      const res = await fetch('/admin/api/dev-login', {
        method: 'POST',
        credentials: 'same-origin',
        headers: { 'Content-Type': 'application/json', 'X-Kashkool-Admin': '1' },
        body: JSON.stringify({ email: $('#dev-email').value }),
      });
      const data = await res.json().catch(() => ({}));
      if (res.ok) showApp(data.email);
      else showLogin(data.message || 'مش مسموح');
    });

    const cfg = await fetch('/admin/api/public-config').then((r) => r.json()).catch(() => ({}));
    $('#dev-login').hidden = !cfg.devLogin;

    const me = await fetch('/admin/api/me', { credentials: 'same-origin' });
    if (me.ok) {
      await showApp((await me.json()).email);
    } else {
      showLogin();
    }
    renderGoogleButton(cfg.googleClientId);
  }

  boot();
})();
