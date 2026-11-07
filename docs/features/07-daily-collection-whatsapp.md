# 07 — Daily Collection & WhatsApp Reminders (التحصيل والتذكيرات)

**Phase:** 1 · **Tier:** Free · **Depends on:** 00 Onboarding, 02 Customers, 03 Transactions, 05 Rating, 12 Basic Settings

## User story
As a shop owner, I want one daily nudge listing who I should remind, and to send each one a polite WhatsApp message with all details in one tap — for free, from my own number, even if my phone brand aggressively kills background apps.

## Who is "due"?
A customer is due when **all** conditions are true:
1. `balance > 0`
2. `phone` is not null and valid
3. `oldestUnpaidAgeDays ≥ settings.minDebtAgeDays` (default 3 days)
4. `lastReminderAt` is null or $\ge \text{settings.reminderIntervalDays}$ (default 7 days) ago
5. `snoozedUntil` is null or in the past

---

## Dual Trigger Architecture (Daily Notification + App Open Recomputation)

> [!IMPORTANT]
> **Aggressive OEM Battery Killing Defense**:
> Android devices from popular Egyptian vendors (Infinix, Tecno, Xiaomi/Redmi, Oppo, Realme) frequently kill background `workmanager` tasks when the phone is locked or on battery saver. To guarantee the shop owner never misses collections:
> 1. **Primary**: Daily scheduled background notification via `workmanager` + `flutter_local_notifications` at `settings.reminderTime` (default 10:00 AM).
> 2. **Fallback — Recompute on App Open**: Every time the app transitions from background to foreground (`AppLifecycleState.resumed`) or cold starts:
>    - The collection repository re-evaluates the due list in under 50ms.
>    - If any customers or installments are due today and no notification was delivered, an in-app badge ("🔥 عندك عملاء مستحقين للتحصيل") appears immediately on the Collection tab.

---

## Daily notification
- Text: "عندك 6 عملاء عليهم 3,450 ج.م — اضغط للتحصيل".
- If 0 customers are due, the notification is skipped.
- Tap notification → deep links directly to the Collection screen.
- Survives device reboot via `RECEIVE_BOOT_COMPLETED` permission.

---

## Collection screen
- Two tabs:
  1. **ديون الحسابات (Ledger Customers)**: Customers meeting the credit due criteria.
  2. **أقساط مستحقة (Due Installments)**: Scheduled installment payments due today or overdue (14).
- Header: count + total due amount.
- List sorted by rating (🔴 Late first, then 🟡 Watch, then amount).
- Each row contains:
  - Name, phone, amount due, rating badge, days since oldest debt, last reminder date.
  - Action buttons: **WhatsApp** (primary 1-tap) · **SMS** (fallback) · **Call** · **⋯** (snooze 3/7 days, record payment).
- After returning from WhatsApp (`AppLifecycleState.resumed`):
  - In-app dialog asks: "هل تم إرسال الرسالة لـ [اسم العميل]؟"
  - Tapping **"نعم، اتبعتت"** sets `lastReminderAt = now()`, and the row animates out of today's collection list.

---

## WhatsApp launch & fallback
```
https://wa.me/{20XXXXXXXXXX}?text={Uri.encodeComponent(message)}
```
- Launched via `url_launcher` with `LaunchMode.externalApplication`.
- If WhatsApp is not installed on the device, presents an automatic dialog offering SMS fallback:
  ```
  sms:{01XXXXXXXXX}?body={Uri.encodeComponent(message)}
  ```

---

## Message templates (Configured in 00 / 12)
Placeholders dynamically injected:
- `{customer_name}`: Customer name
- `{shop_name}`: Shop name from settings
- `{balance}`: Current balance formatted in EGP
- `{last_transaction_date}`: Date of last debt/payment
- `{last_transaction_amount}`: Amount of last transaction
- `{payment_info}`: InstaPay address or Vodafone Cash number
- Growth footer (11) appended automatically at the bottom.

### Default Template (Friendly / ودي):
```
السلام عليكم أ/ {customer_name} 👋
معاك {shop_name}.
بنفكر حضرتك بخصوص الحساب المتبقي: {balance}
آخر عملية: {last_transaction_date} بمبلغ {last_transaction_amount}
طرق الدفع المتاحة: {payment_info}
شكراً لذوقك وتعاملك معانا 🙏
```

---

## Acceptance Criteria
- [ ] Due-list logic covered by unit tests (verifying each condition individually and combined).
- [ ] Notification fires daily at the chosen time; survives reboot.
- [ ] Opening app recomputes due customers immediately even if background notification was killed.
- [ ] WhatsApp opens directly to the customer's chat with Arabic text and emojis intact.
- [ ] Returning and confirming updates `lastReminderAt` and removes customer from due list.
- [ ] Battery optimization guide accessible from Collection empty/info state.
