# 07 — Daily Collection & WhatsApp Reminders (التحصيل)

**Phase:** 1 · **Tier:** Free · **Depends on:** 02, 03, 05, 12

## User story
As a shop owner, I want one daily nudge listing who I should remind, and to
send each one a polite WhatsApp message with all details in one tap — for free,
from my own number.

## Who is "due"?
A customer is due when **all** are true:
- balance > 0
- has phone
- `oldestUnpaidAgeDays ≥ settings.minDebtAgeDays` (default 3)
- `lastReminderAt` is null or ≥ `settings.reminderIntervalDays` (default 7) ago
- `snoozedUntil` is null or in the past

## Daily notification
- `workmanager` periodic task + `flutter_local_notifications`, at `settings.reminderTime` (default 10:00).
- Text: "عندك 6 عملاء عليهم 3,450 ج.م — اضغط للتحصيل". Skip if 0 due.
- Tap → deep link to Collection tab.
- Must survive device reboot; request notification permission (Android 13+) with explanation screen.

## Collection screen
- Header: count + total due.
- List sorted by rating (red first) then amount.
- Each row: name, amount, days since oldest debt, last reminder date, and buttons:
  - **WhatsApp** (primary) · **SMS** · **Call** · **⋯** (snooze 3 / 7 days, mark collected → opens payment sheet).
- After returning from WhatsApp (`AppLifecycleState.resumed`) → ask "اتبعت؟" (Yes / No).
  Yes → set `lastReminderAt = now`, row animates out.

## WhatsApp launch
```
https://wa.me/{20XXXXXXXXXX}?text={Uri.encodeComponent(message)}
```
- Use `url_launcher` with `LaunchMode.externalApplication`.
- If WhatsApp not installed → offer SMS: `sms:{01XXXXXXXXX}?body={encoded}`.

## Message template (editable in Settings)
Placeholders: `{customer_name}` `{shop_name}` `{balance}` `{last_transaction_date}`
`{last_transaction_amount}` `{payment_info}` + growth footer (11) appended automatically.

Default (friendly):
```
السلام عليكم أ/ {customer_name} 👋
معاك {shop_name}.
رصيدك الحالي: {balance}
آخر عملية: {last_transaction_date} - {last_transaction_amount}
للدفع: {payment_info}
شكراً لتعاملك معانا 🙏
```
Also ship a "formal" preset. Preview with real data in settings.

## Acceptance Criteria
- [ ] Due-list logic covered by unit tests (each condition).
- [ ] Notification fires daily at chosen time, incl. after reboot; not shown when 0 due.
- [ ] WhatsApp opens on the right chat with full Arabic text + emojis intact.
- [ ] SMS fallback works when WhatsApp missing.
- [ ] Returning and confirming updates `lastReminderAt`; customer leaves the list.
